import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/state_manager/splash_cubit/splash_state.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';

class SplashCubit extends Cubit<SplashState> {
  late final IAuthRepo _auth;
  SplashCubit(this._auth) : super(const SplashState());
  Future<bool> checkDevice() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      bool isRegister = await _auth.checkLogin();
      return isRegister;
    } catch (e) {
      AppDialog.defaultDialog(message: "Error $e");
    }
    return false;
  }
}
