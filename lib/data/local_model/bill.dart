import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/order.dart';
part 'bill.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_BILL)
class Bill {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: [])
  List<Order>? orders;
  @HiveField(2, defaultValue: 0.0)
  double? total;
  @HiveField(3, defaultValue: '')
  String? code;
  @HiveField(4, defaultValue: '')
  String? username;
  @HiveField(5, defaultValue: '')
  String? craetedAt;
  @HiveField(6, defaultValue: '')
  String? updatedAt;
  Bill(
      {this.code,
      this.craetedAt,
      this.hiveId,
      this.orders,
      this.total,
      this.updatedAt,
      this.username});
}
