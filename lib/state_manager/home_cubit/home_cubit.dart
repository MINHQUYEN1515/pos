import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/state_manager/home_cubit/home_state.dart';
import 'package:pos/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/enum.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences _pref;
  late ITableRepo _tableRepo;
  HomeCubit(this._pref, this._tableRepo) : super(const HomeState());
  UserPos? get user => _pref.users;
  void changeScreen(Screen screen) {
    emit(state.copyWith(screen: screen));
  }

  void fetchData() async {
    // await _tableRepo.clear();
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      var data = await _tableRepo.getAll();
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
      if (status != AppConstants.TABLE_ALL) {
        data = data.where((e) => e.status == status).toList();
      }
      emit(state.copyWith(status: LoadStatus.success, tables: data));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  List<TablePos> get tables => state.tables;
}
