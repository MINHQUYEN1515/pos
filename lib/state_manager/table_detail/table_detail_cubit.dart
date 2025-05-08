import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:collection/collection.dart';
import 'package:pos/data/repositories/interface/iorder_item.dart';
import 'package:pos/data/repositories/interface/iorder_repo.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'table_detail_state.dart';

class TableDetailCubit extends Cubit<TableDetailState> {
  late IProductRepo _productRepo;
  late IOrderItemRepo _orderTemp;
  late SharedPreferences _pref;
  late ITableRepo _tableRepo;
  late IOrderRepo _order;
  TableDetailCubit(this._productRepo, this._pref, this._orderTemp,
      this._tableRepo, this._order)
      : super(TableDetailState());
  Future<double> loadData(
      {required TablePos table, String? fillter, int? position}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      if (fillter != null) {
        data = data.where((e) => e.type == fillter).toList();
      }
      var orderTemp = await _orderTemp.getAll();
      logger.i(orderTemp);
      if (position != 0) {
        orderTemp = orderTemp.where((e) => e.position == position).toList();
      }
      logger.i(table.tableId);
      orderTemp = orderTemp.where((e) => e.tableId == table.tableId).toList();
      emit(state.copyWith(
        product: data,
        orderTemp: orderTemp,
        table: table,
        status: LoadStatus.success,
      ));
      return _getTotal(orderTemp);
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
    return 0;
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

  void addOrderTemp(
      {required OrderItem order,
      int? position,
      required String tableId}) async {
    try {
      var temp = await _orderTemp.findOrder(
          productId: order.product!.code!, tableId: tableId);
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

  _getTotal(List<OrderItem> items) {
    double _price = 0;
    items.forEach((e) {
      _price += e.totalAmount!;
      e.extras?.forEach((ele) {
        _price += ele.total!;
      });
    });
    return _price;
  }

  Future paymeny({required Order order}) async {
    await _order.insert(order: order);
  }

  void deleteOrderTemp({required String tableId}) async {
    await _orderTemp.deleteOrderWhenPay(tableId: tableId);
    TablePos? _table = state.table;
    if (_table == null) return;
    var data = await _orderTemp.getAll();
    data = data.where((e) => e.tableId == _table.tableId).toList();

    _table.status = AppConstants.TABLE_EMPTY;
    _table.amount = 0;
    _table.userName = user?.username;
    await _tableRepo.updateTable(table: _table);
  }

  Future changeTable(
      {required String tableIdFrom, required String tableIdTo}) async {
    var data = await _tableRepo.getAll();
    TablePos? _tableFrom =
        data.where((e) => e.code == tableIdFrom).toList().first;
    TablePos? _tableTo = data.where((e) => e.code == tableIdTo).toList().first;
    double _price = 0;
    if (_tableTo == null || _tableFrom == null) {
      AppDialogCustomer.showConfirmDialog("Không tìm thấy ban!");
      return;
    }
    List<OrderItem> orders = await _orderTemp.getAll();
    orders = orders.where((e) => e.tableId == _tableFrom.tableId).toList();
    List<OrderItem> orderTo = await _orderTemp.getAll();
    orderTo = orderTo.where((e) => e.tableId == _tableTo.tableId).toList();
    orders.forEach((e) async {
      _price += (e.quantity! * e.product!.price!);
      e.product?.extras?.forEach((el) {
        _price += el.price;
      });
      e.tableId = _tableTo.tableId;
      await _orderTemp.updateOrder(order: e);
    });
    _tableFrom.status = AppConstants.TABLE_EMPTY;
    _tableFrom.amount = 0;
    _tableFrom.userName = user?.username;

    orderTo.forEach((e) {
      _price += (e.quantity! * e.product!.price!);
      e.product?.extras?.forEach((el) {
        _price += el.price;
      });
    });
    _tableTo.status = AppConstants.TABLE_USING;
    _tableTo.amount = _price;
    _tableTo.userName = user?.username;
    await _tableRepo.updateTable(table: _tableTo);
    await _tableRepo.updateTable(table: _tableFrom);
  }

  Future mergeTable(
      {required String strTableFrom, required String tableTo}) async {
    List<String> strIdTable = strTableFrom.split(',');
    List<TablePos> table = await _tableRepo.getAll();
    List<TablePos> _tableFrom =
        table.where((e) => strIdTable.contains(e.code)).toList();
    TablePos? _tableTo = table.where((e) => e.code == tableTo).toList().first;
    List<String> _tableId = [];
    _tableFrom.forEach((e) {
      _tableId.add(e.tableId!);
    });
    List<OrderItem> orders = await _orderTemp.getAll();
    orders = orders.where((e) => _tableId.contains(e.tableId)).toList();
    List<OrderItem> orderTo = await _orderTemp.getAll();
    orderTo = orderTo.where((e) => e.tableId == _tableTo.tableId).toList();
    double _price = 0;
    orders.forEach((e) async {
      _price += (e.quantity! * e.product!.price!);
      e.product?.extras?.forEach((el) {
        _price += el.price;
      });
      e.tableId = _tableTo.tableId;
      await _orderTemp.updateOrder(order: e);
    });
    _tableFrom.forEach((e) async {
      e.status = AppConstants.TABLE_EMPTY;
      e.amount = 0;
      e.userName = user?.username;
      await _tableRepo.updateTable(table: e);
    });
    orderTo.forEach((e) {
      _price += (e.quantity! * e.product!.price!);
      e.product?.extras?.forEach((el) {
        _price += el.price;
      });
    });
    _tableTo.status = AppConstants.TABLE_USING;
    _tableTo.amount = _price;
    _tableTo.userName = user?.username;
    await _tableRepo.updateTable(table: _tableTo);
  }

  UserLocal? get user => _pref.users;
  TablePos? get table => state.table;
  OrderItem? get selectOrder => state.selectOrders;
  List<OrderItem> get items => state.orderTemp;
  double get price => state.price;
}
