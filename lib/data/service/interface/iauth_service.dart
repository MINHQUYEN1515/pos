import 'package:pos/data/models/user_pos.dart';

abstract class IAuthService {
  Future<void> saveInfoPos({required String password});
  UserPos? getInfo();
  Future<void> registerDevice({required UserPos user});
}
