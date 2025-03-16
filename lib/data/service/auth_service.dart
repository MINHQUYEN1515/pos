import 'dart:convert';

import 'package:pos/core/constants/database_key.dart';
import 'package:pos/data/database/data_base_local.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:pos/data/service/interface/iauth_service.dart';

class AuthService extends IAuthService {
  final _database = DataBaseLocal.instance;
  @override
  Future<void> saveInfoPos({required String password}) async {
    UserPos pos = UserPos(
        password: password,
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString());
    await _database.setString(DatabaseKey.user, jsonEncode(pos));
  }

  @override
  UserPos? getInfo() {
    try {
      final data = _database.getString(DatabaseKey.user);
      if (data == null) return null;

      final userMap = jsonDecode(data) as Map<String, dynamic>;
      return UserPos.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> registerDevice({required UserPos user}) async {
    await _database.setString(DatabaseKey.user, jsonEncode(user.toJson()));
  }
}
