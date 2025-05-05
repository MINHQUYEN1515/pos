import 'package:pos/core/constants/shared_preferences_key.dart';
import 'package:pos/data/local_model/user_local.dart';
import 'package:pos/data/service/interface/iauth_service.dart';
import 'package:pos/data/service/interface/user_service.dart';
import 'package:pos/extensions/shared_preference_extension.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends IAuthService {
  late IUserService _userService;
  late SharedPreferences _pref;
  AuthService(this._userService, this._pref);

  @override
  Future<bool> login({required UserLocal user}) async {
    try {
      List<UserLocal> users = await _userService.getAll();
      bool flag = false;
      users.forEach((e) {
        if (e.username == user.username && e.password == user.password) {
          flag = true;
          _pref.setUser(e);
        }
      });
      if (flag) {
        return true;
      }
    } catch (e) {
      logger.e(e);
    }
    return false;
  }

  @override
  Future<UserLocal?> registerUser({required UserLocal user}) async {
    try {
      List<UserLocal> users = await _userService.getAll();
      bool flag = false;
      users.forEach((e) {
        if (e.username == user.username) {
          AppDialogCustomer.showDefaultDialog("User name đã tồn tại!");
          flag = true;
        }
      });
      if (flag) {
        return null;
      } else {
        await _userService.insert(user);
        return user;
      }
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    try {
      _pref.remove(SharedPreferencesKey.user);
      return true;
    } catch (e) {
      logger.e(e);

      return false;
    }
  }
}
