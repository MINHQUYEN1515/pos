import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/extra.dart';
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
  @HiveField(11)
  List<Extra>? extras;
  @HiveField(12, defaultValue: 0)
  int? position;
  @HiveField(13)
  bool isOrders;
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
      this.extras,
      this.position,
      this.isOrders = false});
  OrderItem copyWith(
      {String? hiveId,
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
      List<Extra>? extras,
      int? position,
      bool? isOrders}) {
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
      ..extras = extras ?? this.extras
      ..position = position ?? this.position
      ..isOrders = isOrders ?? this.isOrders;
  }

  Map<String, dynamic> toJson() {
    return {
      'hiveId': hiveId,
      'code': code,
      'username': username,
      'amount': amount,
      'product': product?.toJson(), // Requires Product.toJson()
      'quantity': quantity,
      'craetedAt': craetedAt,
      'updatedAt': updatedAt,
      'totalAmount': totalAmount,
      'tableId': tableId,
      'note': note,
      'extras': extras
          ?.map((extra) => extra.toJson())
          .toList(), // Requires Extra.toJson()
      'position': position,
      'is_orders': isOrders
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        hiveId: json['hiveId'],
        code: json['code'],
        username: json['username'],
        amount: json['amount']?.toDouble(),
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        quantity: json['quantity'],
        craetedAt: json['craetedAt'],
        updatedAt: json['updatedAt'],
        totalAmount: json['totalAmount']?.toDouble(),
        tableId: json['tableId'],
        note: json['note'],
        extras: json['extras'] != null
            ? (json['extras'] as List).map((e) => Extra.fromJson(e)).toList()
            : null,
        position: json['position'],
        isOrders: json['is_orders']);
  }
}
