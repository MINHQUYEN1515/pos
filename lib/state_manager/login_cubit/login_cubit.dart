import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/state_manager/login_cubit/login.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';

import '../../data/repositories/repo.dart';

class LoginCubit extends Cubit<LoginState> {
  late final IAuthRepo _auth;
  LoginCubit(this._auth) : super(const LoginState());

  Future<bool> login({required String password}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      bool user = await _auth.login(password: password);
      if (user) {
        emit(state.copyWith(status: LoadStatus.success));
        AppDialog.defaultDialog(message: "LOGIN SUCCESS");
        return true;
      }
      AppDialog.defaultDialog(message: "LOGIN FAILD");
      return false;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      AppDialog.defaultDialog(message: "$e");
    }
    return false;
  }
}
