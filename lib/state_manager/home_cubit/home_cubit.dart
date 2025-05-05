import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/state_manager/home_cubit/home_state.dart';
import 'package:pos/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/enum.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences _pref;
  late ITableRepo _tableRepo;
  late IAuthRepo _auth;
  HomeCubit(this._pref, this._tableRepo, this._auth) : super(const HomeState());
  UserLocal? get user => _pref.users;
  void changeScreen(Screen screen) {
    emit(state.copyWith(screen: screen));
  }

  void fetchData() async {
    // await _tableRepo.clear();
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _tableRepo.getAll();
      data = data.where((e) => e.position == state.position).toList();
      emit(state.copyWith(tables: data, status: LoadStatus.success));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void fillterTable(String status) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _tableRepo.getAll();
      data = data.where((e) => e.position == state.position).toList();
      if (status != AppConstants.TABLE_ALL) {
        data = data.where((e) => e.status == status).toList();
      }
      emit(state.copyWith(
          status: LoadStatus.success, tables: data, type: status));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void changePosition(String position) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _tableRepo.getAll();
      data = data.where((e) => e.position == position).toList();
      if (state.type != AppConstants.TABLE_ALL) {
        data = data.where((e) => e.status == state.type).toList();
      }
      emit(state.copyWith(
          status: LoadStatus.success, tables: data, position: position));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<bool> logout(context) async {
    return await _auth.logout();
  }

  List<TablePos> get tables => state.tables;
}
