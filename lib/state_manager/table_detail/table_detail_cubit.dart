import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/order_item.dart';
import 'package:pos/data/local_model/user_local.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/iorder_item.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'table_detail_state.dart';

class TableDetailCubit extends Cubit<TableDetailState> {
  late IProductRepo _productRepo;
  late IOrderItemRepo _orderTemp;
  late SharedPreferences _pref;
  TableDetailCubit(this._productRepo, this._pref, this._orderTemp)
      : super(TableDetailState());
  void loadData() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      var orderTemp = await _orderTemp.getAll();

      emit(state.copyWith(
          product: data, orderTemp: orderTemp, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void fillterData({required String fillter}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      data = data.where((e) => e.type == fillter).toList();
      emit(state.copyWith(product: data, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void addOrderTemp({required OrderItem order}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      await _orderTemp.insertData(order);
      loadData();
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  UserLocal? get user => _pref.users;
}
