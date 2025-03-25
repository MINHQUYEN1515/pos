import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/local_model/table.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/state_manager/setting_cubit/setting_state.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/logger.dart';
import 'package:pos/utils/product_utils.dart';
import 'package:pos/utils/table_utils.dart';

class SettingCubit extends Cubit<SettingState> {
  final ITableRepo _tableRepo;
  final IProductRepo _productRepo;
  SettingCubit(this._tableRepo, this._productRepo) : super(SettingState());
  void craeteTable({
    required String tableName,
    required String code,
    required int seats,
    required String position,
    String? imageBase64,
  }) async {
    emit(state.copyWith(status: LoadStatus.loading));
    TablePos table = TableUtils.createTable(
        tableName: tableName, code: code, seats: seats, position: position);

    try {
      await _tableRepo.insertTable(table);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      logger.e(e);
      AppDialog.defaultDialog(message: "Vui lòng nhập đúng định dạng");
    }
  }

  void createProduct(
      {required String name,
      required double price,
      required String type,
      required String code}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    Product product = ProductUtils.createProduct(
        name: name, price: price, type: type, code: code);
    try {
      await _productRepo.insertData(product: product);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      logger.e(e);
      AppDialog.defaultDialog(message: "Vui lòng nhập đúng định dạng");
    }
  }
}
