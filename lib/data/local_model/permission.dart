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
  cash,
}
