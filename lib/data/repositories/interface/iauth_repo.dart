import 'package:pos/data/models/user_pos.dart';

abstract class IAuthRepo {
  Future<void> login({required String userName, required String password});
  Future<void> checkLogin();
  Future<void> resgisterUser({required UserPos user});
}
