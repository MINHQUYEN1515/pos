import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/state_manager/home_cubit/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/enum.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences _pref;
  HomeCubit(this._pref) : super(const HomeState());
  UserPos? get user => _pref.users;
  void changeScreen(Screen screen) {
    emit(state.copyWith(screen: screen));
  }
}
