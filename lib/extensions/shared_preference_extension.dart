import 'dart:convert';

import 'package:pos/core/constants/shared_preferences_key.dart';
import 'package:pos/data/local_model/user_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  UserLocal? get users {
    try {
      final data = this.getString(SharedPreferencesKey.user);
      if (data == null) return null;

      final userMap = jsonDecode(data) as Map<String, dynamic>;
      return UserLocal.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  void setUser(UserLocal user) {
    this.setString(SharedPreferencesKey.user, jsonEncode(user.toJson()));
  }
}
