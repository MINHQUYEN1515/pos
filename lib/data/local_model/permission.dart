import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/core/constants/local_constants.dart';
part 'permission.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_PERMISSION)
enum Permission {
  @HiveField(0)
  admin,

  @HiveField(1)
  user,

  @HiveField(2)
  cash;

  // Convert enum to String value
  String toJson() => name;

  // Create enum from String value
  static Permission fromJson(String json) => values.byName(json);

  // Helper method to get display name if needed
  String get displayName {
    switch (this) {
      case Permission.admin:
        return 'Administrator';
      case Permission.user:
        return 'User';
      case Permission.cash:
        return 'Cashier';
    }
  }
}
