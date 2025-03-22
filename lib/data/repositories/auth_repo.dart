import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/service/interface/iauth_service.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/utils/security_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends IAuthRepo {
  late IAuthService _iAuthService;
  late SharedPreferences _pref;
  AuthRepo(this._iAuthService, this._pref);
  @override
  Future<bool> login({required String password}) async {
    try {
      UserPos? user = await _iAuthService.getInfo();
      final check = SecurityUtils.generateMd5(password);
      if (user!.isLogin) {
        return true;
      }
      if (check == user.password) {
        user.isLogin = true;
        _pref.setUser(user);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> checkLogin() async {
    UserPos? user = _iAuthService.getInfo();
    if (user == null) return false;
    return true;
  }

  @override
  Future<void> resgisterUser({required UserPos user}) async {
    _iAuthService.registerDevice(user: user);
  }

  @override
  Future<bool> isLogin() async {
    try {
      UserPos? user = await _iAuthService.getInfo();
      if (user!.isLogin) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
