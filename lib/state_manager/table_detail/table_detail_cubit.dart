import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:collection/collection.dart';
import 'package:pos/data/repositories/interface/iorder_item.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'table_detail_state.dart';

class TableDetailCubit extends Cubit<TableDetailState> {
  late IProductRepo _productRepo;
  late IOrderItemRepo _orderTemp;
  late SharedPreferences _pref;
  late ITableRepo _tableRepo;
  TableDetailCubit(
      this._productRepo, this._pref, this._orderTemp, this._tableRepo)
      : super(TableDetailState());
  void loadData(
      {required TablePos table, String? fillter, int? position}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      if (fillter != null) {
        data = data.where((e) => e.type == fillter).toList();
      }
      var orderTemp = await _orderTemp.getAll();
      if (position != 0) {
        orderTemp = orderTemp.where((e) => e.position == position).toList();
      }

      orderTemp = orderTemp.where((e) => e.tableId == table.tableId).toList();
      emit(state.copyWith(
          product: data,
          orderTemp: orderTemp,
          table: table,
          status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void fillterData({required String fillter, int? position}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      data = data.where((e) => e.type == fillter).toList();
      loadData(table: state.table!, fillter: fillter, position: position);
      emit(state.copyWith(
          product: data, fillter: fillter, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void addOrderTemp({required OrderItem order, int? position}) async {
    try {
      var temp = await _orderTemp.findOrder(productId: order.product!.code!);
      temp = temp?.position == position ? temp : null;
      if (temp == null) {
        await _orderTemp.insertData(order);
      } else {
        temp.quantity = temp.quantity! + 1;
        temp.totalAmount = temp.quantity! * temp.product!.price!;
        List<Extra> _extraTemp = [];
        _extraTemp.addAll(temp.extras ?? []);
        _extraTemp.addAll(order.extras ?? []);

        var grouped = groupBy(_extraTemp, (Extra p) => p.name);
        // Gộp lại thành danh sách mới chỉ chứa 1 item mỗi category với tổng tiền
        List<Extra> result = grouped.entries.map((entry) {
          String? name = entry.key;
          double total =
              entry.value.fold(0, (sum, p) => sum + (p.price * p.quantity));
          int quantity = entry.value.fold(0, (sum, p) => sum + p.quantity);
          return Extra(
              hiveId: Uuid().v4(),
              name: name,
              quantity: quantity,
              total: total,
              price:
                  entry.value.first.price); // dùng tên category luôn cho name
        }).toList();
        temp = temp.copyWith(extras: result);
        await _orderTemp.updateOrder(order: temp);
      }

      emit(state.copyWith(status: LoadStatus.success));
      loadData(table: state.table!, fillter: state.fillter, position: position);
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void selectOrders({required OrderItem order}) async {
    if (state.selectOrders?.hiveId == order.hiveId) {
      emit(state.copyWith(selectOrders: OrderItem()));
    } else {
      emit(state.copyWith(selectOrders: order));
    }
  }

  void updateOrder({required OrderItem order, int? position}) {
    _orderTemp.updateOrder(order: order);
    if (order.quantity == 0) {
      _orderTemp.deleteOrder(order: order);
    }
    loadData(table: state.table!, fillter: state.fillter);
  }

  void deleteOrder({required OrderItem order, int? position}) async {
    _orderTemp.deleteOrder(order: order);
    loadData(table: state.table!, fillter: state.fillter);
  }

  void findProduct({String search = ''}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      data = data.where((e) => e.code!.contains(search)).toList();
      emit(state.copyWith(product: data, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void loadPosition({required int position}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _orderTemp.getAll();
      if (position != 0) {
        data = data.where((e) => e.position == position).toList();
      }
      emit(state.copyWith(orderTemp: data, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<bool> order() async {
    try {
      TablePos? _table = state.table;
      if (_table == null) return false;
      var data = await _orderTemp.getAll();
      data = data.where((e) => e.tableId == _table.tableId).toList();
      double _price = 0;
      data.forEach((e) {
        _price += e.totalAmount!;
        e.extras?.forEach((ele) {
          _price += ele.total!;
        });
      });

      _table.status = AppConstants.TABLE_USING;
      _table.amount = _price;
      _table.userName = user?.username;
      await _tableRepo.updateTable(table: _table);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  UserLocal? get user => _pref.users;
  TablePos? get table => state.table;
  OrderItem? get selectOrder => state.selectOrders;
  List<OrderItem> get items => state.orderTemp;
}
