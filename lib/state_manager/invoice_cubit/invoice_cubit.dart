import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/repositories/interface/iorder_repo.dart';

import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  late IOrderRepo _repo;
  late IAuthRepo _authRepo;
  InvoiceCubit(this._repo, this._authRepo) : super(const InvoiceState());
  void fetchData() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _repo.getAll();
      var users = await _authRepo.getAll();
      users = users.where((e) => e.permission != Permission.admin).toList();
      data = data
          .where((e) =>
              DateTime.parse(e.createdAt.toString())
                  .isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
              DateTime.parse(e.createdAt.toString())
                  .isBefore((DateTime.now().add(const Duration(days: 1)))))
          .toList();
      List<String> userNamestr = [];
      users.forEach((e) {
        userNamestr.add(e.username!);
      });
      userNamestr.insert(0, 'Tất cả nhân viên');
      emit(state.copyWith(
          invoices: data, users: userNamestr, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void fillterData(
      {required DateTime startDay,
      required DateTime endDay,
      String? username,
      String? typeBill}) async {
    try {
      var data = await _repo.getAll();
      data = data
          .where((e) =>
              DateTime.parse(e.createdAt.toString())
                  .isAfter(startDay.subtract(const Duration(days: 1))) &&
              DateTime.parse(e.createdAt.toString())
                  .isBefore((endDay.add(const Duration(days: 1)))))
          .toList();
      if (username != null && username != 'Tất cả nhân viên') {
        data = data.where((e) => e.username == username).toList();
      }
      if (typeBill != null && typeBill != AppConstants.ALl) {
        data = data.where((e) => e.payment == typeBill).toList();
      }
      if (data.isEmpty) {
        data = [];
      }
      emit(state.copyWith(invoices: data, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }
}
