import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/product.dart';
part 'order_item.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_ORDER_ITEM)
class OrderItem {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: '')
  String? code;
  @HiveField(2, defaultValue: '')
  String? username;
  @HiveField(3, defaultValue: 0.0)
  double? amount;
  @HiveField(4, defaultValue: null)
  Product? product;
  @HiveField(5, defaultValue: 0.0)
  double? quantity;
  @HiveField(6, defaultValue: '')
  String? craetedAt;
  @HiveField(7, defaultValue: '')
  String? updatedAt;
  @HiveField(8, defaultValue: 0.0)
  double? totalAmount;
  @HiveField(9, defaultValue: 0)
  int? tableId;
  @HiveField(10, defaultValue: '')
  String? note;
  OrderItem(
      {this.hiveId,
      this.code,
      this.amount,
      this.product,
      this.quantity,
      this.updatedAt,
      this.craetedAt,
      this.username,
      this.totalAmount,
      this.tableId,
      this.note});
}
