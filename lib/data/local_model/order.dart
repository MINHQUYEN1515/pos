import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/order_item.dart';
part 'order.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_ORDER)
class Order {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: 0.0)
  double? amount;
  @HiveField(2, defaultValue: [])
  List<OrderItem>? items;
  @HiveField(3, defaultValue: '')
  String? createdAt;
  @HiveField(4, defaultValue: '')
  String? updatedAt;
  @HiveField(5, defaultValue: 0)
  double? total;
  @HiveField(6, defaultValue: '')
  String? username;
  @HiveField(7, defaultValue: '')
  String? payment;
  Order(
      {this.hiveId,
      this.amount,
      this.items,
      this.createdAt,
      this.updatedAt,
      this.payment,
      this.total,
      this.username});
}
