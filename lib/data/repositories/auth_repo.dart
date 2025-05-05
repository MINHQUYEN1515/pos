import 'package:pos/data/local_model/user_local.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/service/interface/iauth_service.dart';
import 'package:pos/data/service/interface/user_service.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/utils/logger.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends IAuthRepo {
  late IAuthService _iAuthService;
  late IUserService _userService;
  late SharedPreferences _pref;
  AuthRepo(this._iAuthService, this._pref, this._userService);

  @override
  Future<bool> login({required UserLocal user}) {
    return _iAuthService.login(user: user);
  }

  @override
  Future<UserLocal?> registerUser({required UserLocal user}) {
    return _iAuthService.registerUser(user: user);
  }

  @override
  Future<bool> isLogin() async {
    return _pref.users?.hiveId != null;
  }

  @override
  Future<List<UserLocal>> getAll() async {
    return await _userService.getAll();
  }

  @override
  Future<bool> createUser({required UserLocal user}) async {
    try {
      await _userService.insert(user);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteUser({required String hiveId}) async {
    return await _userService.delete(hiveId);
  }

  @override
  Future<bool> logout() async {
    return await _iAuthService.logout();
  }
}
