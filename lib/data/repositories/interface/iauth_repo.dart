import '../../local_model/user_local.dart';

abstract class IAuthRepo {
  Future<UserLocal?> registerUser({required UserLocal user});
  Future<bool> login({required UserLocal user});
  Future<bool> isLogin();
  Future<List<UserLocal>> getAll();
}
