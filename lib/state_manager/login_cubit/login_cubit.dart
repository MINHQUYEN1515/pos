import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/user_local.dart';
import 'package:pos/state_manager/login_cubit/login.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';

import '../../data/repositories/repo.dart';

class LoginCubit extends Cubit<LoginState> {
  late final IAuthRepo _auth;
  LoginCubit(this._auth) : super(const LoginState());

  Future<bool> login(
      {required String password, required String username}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      bool user = await _auth.login(
          user: UserLocal(username: username, password: password));
      if (user) {
        emit(state.copyWith(status: LoadStatus.success));
        AppDialogCustomer.showConfirmDialog("LOGIN SUCCESS");
        return true;
      }
      return false;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      AppDialogCustomer.showConfirmDialog("$e");
    }
    return false;
  }

  Future<bool> isLogin() async {
    if (await _auth.isLogin()) {
      return true;
    } else {
      return false;
    }
  }
}
