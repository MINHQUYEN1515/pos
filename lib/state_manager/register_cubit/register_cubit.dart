import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/security_utils.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late final IAuthRepo _auth;
  RegisterCubit(this._auth) : super(const RegisterState());
  void register({required String name}) async {
    emit(state.copyWith(status: LoadStatus.loading));
    print(1);
    try {
      await _auth.resgisterUser(
          user: UserPos(
              userName: name,
              isLogin: false,
              language: 'vi',
              password: SecurityUtils.generateMd5("12345678"),
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString()));
      AppDialog.defaultDialog(
        message: "Register Device Success!",
      );
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }
}
