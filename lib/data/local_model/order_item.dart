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
  @HiveField(5, defaultValue: 0)
  int? quantity;
  @HiveField(6, defaultValue: '')
  String? craetedAt;
  @HiveField(7, defaultValue: '')
  String? updatedAt;
  @HiveField(8, defaultValue: 0.0)
  double? totalAmount;
  @HiveField(9, defaultValue: '')
  String? tableId;
  @HiveField(10, defaultValue: '')
  String? note;
  @HiveField(11, defaultValue: '')
  String? extras;
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
      this.note,
      this.extras});
  OrderItem copyWith({
    String? hiveId,
    String? code,
    String? username,
    double? amount,
    Product? product,
    int? quantity,
    String? craetedAt,
    String? updatedAt,
    double? totalAmount,
    String? tableId,
    String? note,
    String? extras,
  }) {
    return OrderItem()
      ..hiveId = hiveId ?? this.hiveId
      ..code = code ?? this.code
      ..username = username ?? this.username
      ..amount = amount ?? this.amount
      ..product = product ?? this.product
      ..quantity = quantity ?? this.quantity
      ..craetedAt = craetedAt ?? this.craetedAt
      ..updatedAt = updatedAt ?? this.updatedAt
      ..totalAmount = totalAmount ?? this.totalAmount
      ..tableId = tableId ?? this.tableId
      ..note = note ?? this.note
      ..extras = extras ?? this.extras;
  }
}
