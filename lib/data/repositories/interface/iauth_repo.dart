import 'package:pos/data/models/user_pos.dart';

abstract class IAuthRepo {
  Future<bool> login({required String password});
  Future<bool> checkLogin();
  Future<void> resgisterUser({required UserPos user});
}
