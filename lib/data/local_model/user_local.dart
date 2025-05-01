import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/data/local_model/permission.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/local_constants.dart';
part 'user_local.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_USER)
class UserLocal {
  @HiveField(0, defaultValue: '')
  final String? hiveId;
  @HiveField(1, defaultValue: '')
  final String? username;
  @HiveField(2, defaultValue: '')
  final String? password;
  @HiveField(3)
  final Permission? permission;

  UserLocal({this.hiveId, this.username, this.password, this.permission});
  UserLocal copyWith(
      {String? hiveId,
      String? username,
      String? password,
      Permission? permission}) {
    return UserLocal(
        hiveId: hiveId ?? this.hiveId,
        username: username ?? this.username,
        password: password ?? this.password,
        permission: permission ?? this.permission);
  }

  static UserLocal sample() {
    return UserLocal(
      hiveId: Uuid().v4(),
      username: 'admin',
      password: '12345678',
      permission: Permission.admin,
    );
  }

  factory UserLocal.fromJson(Map<String, dynamic> json) {
    return UserLocal(
      hiveId: json['hiveId'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      permission: json['permission'] != null
          ? Permission.values.firstWhere(
              (e) => e.toString() == 'Permission.${json['permission']}',
              orElse: () => Permission.user,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hiveId': hiveId,
      'username': username,
      'password': password,
      'permission': permission?.name,
    };
  }
}
