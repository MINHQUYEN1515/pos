import 'dart:convert';

import 'package:pos/core/constants/shared_preferences_key.dart';
import 'package:pos/data/models/user_pos.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  UserPos? get users {
    try {
      final data = this.getString(SharedPreferencesKey.user);
      if (data == null) return null;

      final userMap = jsonDecode(data) as Map<String, dynamic>;
      return UserPos.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }
}
