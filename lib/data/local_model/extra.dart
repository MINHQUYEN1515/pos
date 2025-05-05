import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/local_constants.dart';
part 'extra.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_EXTRA)
class Extra {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: '')
  String? name;
  @HiveField(2, defaultValue: 0)
  double price;
  @HiveField(3)
  DateTime? createdAt;
  @HiveField(4, defaultValue: 0)
  int quantity;
  @HiveField(5, defaultValue: 0)
  double? total;

  Extra(
      {this.hiveId,
      this.name,
      this.price = 0,
      this.createdAt,
      this.quantity = 1,
      this.total = 0});
}
