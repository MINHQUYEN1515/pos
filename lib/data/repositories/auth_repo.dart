import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/service/interface/iauth_service.dart';
import 'package:pos/utils/security_utils.dart';

class AuthRepo extends IAuthRepo {
  late IAuthService _iAuthService;
  AuthRepo(this._iAuthService);
  @override
  Future<bool> login({required String password}) async {
    UserPos? user = _iAuthService.getInfo();
    final check = SecurityUtils.generateMd5(password);

    if (check == user?.password) {
      return true;
    } else {
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
}
