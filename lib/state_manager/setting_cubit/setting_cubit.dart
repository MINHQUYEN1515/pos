import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/state_manager/setting_cubit/setting_state.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/logger.dart';
import 'package:pos/utils/product_utils.dart';
import 'package:pos/utils/table_utils.dart';
import 'package:uuid/uuid.dart';

class SettingCubit extends Cubit<SettingState> {
  final ITableRepo _tableRepo;
  final IProductRepo _productRepo;
  final IAuthRepo _auth;
  SettingCubit(this._tableRepo, this._productRepo, this._auth)
      : super(SettingState());
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
      loadTable();
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      logger.e(e);
      AppDialogCustomer.showConfirmDialog("Vui lòng nhập đúng định dạng");
    }
  }

  Future<bool> createProduct(
      {required String name,
      required double price,
      required String type,
      required String code,
      String? codeExtra,
      double? priceExtra}) async {
    emit(state.copyWith(status: LoadStatus.loading));

    Product product = ProductUtils.createProduct(
        name: name,
        price: price,
        type: type,
        code: code,
        extras: (codeExtra != null && codeExtra != '' && priceExtra != 0)
            ? [
                Extra(
                    hiveId: Uuid().v1(),
                    createdAt: DateTime.now(),
                    name: codeExtra,
                    price: priceExtra ?? 0)
              ]
            : []);
    try {
      var data = await _productRepo.insertData(product: product);
      loadProduct();
      return true;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      logger.e(e);
      AppDialogCustomer.showConfirmDialog("Vui lòng nhập đúng định dạng");
      return false;
    }
  }

  void loadTable() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _tableRepo.getAll();
      emit(state.copyWith(status: LoadStatus.success, table: data));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void loadProduct() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _productRepo.getAll();
      emit(state.copyWith(status: LoadStatus.success, product: data));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void loadUser() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _auth.getAll();
      data = data.where((e) => e.permission != Permission.admin).toList();
      emit(state.copyWith(status: LoadStatus.success, users: data));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void deleteProduct({required String hiveId}) async {
    await _productRepo.delete(hiveId: hiveId);
    loadProduct();
  }

  void updateProduct({required Product product}) async {
    await _productRepo.updateProduct(product: product);
    loadProduct();
  }

  void deleteTable({required String hiveId}) async {
    await _tableRepo.deleteTable(id: hiveId);
    loadTable();
  }

  void updateTable({required TablePos table}) async {
    await _tableRepo.updateTable(table: table);
    loadTable();
  }

  Future createUser({required UserLocal user}) async {
    await _auth.createUser(user: user);
    loadUser();
  }

  Future deleteUser({required String hiveId}) async {
    await _auth.deleteUser(hiveId: hiveId);
    loadUser();
  }
}
