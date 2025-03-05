import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/repositories/interface/iauth_repo.dart';
import 'package:pos/data/service/interface/iauth_service.dart';

class AuthRepo extends IAuthRepo {
  late IAuthService _iAuthService;
  AuthRepo(this._iAuthService);
  @override
  Future<void> login(
      {required String userName, required String password}) async {}
  @override
  Future<void> checkLogin() async {}
  @override
  Future<void> resgisterUser({required UserPos user}) async {}
}
