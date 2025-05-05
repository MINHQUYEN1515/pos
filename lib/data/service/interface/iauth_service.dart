import '../../local_model/user_local.dart';

abstract class IAuthService {
  Future<UserLocal?> registerUser({required UserLocal user});
  Future<bool> login({required UserLocal user});
  Future<bool> logout();
}
