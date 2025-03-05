import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late IAuthRepo _auth;
  RegisterCubit(this._auth) : super(const RegisterState());
}
