import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
part 'table.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_TABLE)
class TablePos {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: '')
  String? code;
  @HiveField(2, defaultValue: 0)
  int? seats;
  @HiveField(3, defaultValue: 0.0)
  double? amount;
  @HiveField(4, defaultValue: [])
  List<Product>? products = [];
  @HiveField(5, defaultValue: '')
  String? craetedAt;
  @HiveField(6, defaultValue: '')
  String? updatedAt;
  @HiveField(7, defaultValue: '')
  String? tableId;
  @HiveField(8, defaultValue: [])
  List<OrderItem>? orderTemp;
  @HiveField(9, defaultValue: '')
  String? imageBase64;
  @HiveField(10, defaultValue: '')
  String? userName;
  @HiveField(11, defaultValue: '')
  String? position;
  @HiveField(12, defaultValue: '')
  String? status;
  @HiveField(13)
  DateTime? timeOrder;
  TablePos(
      {this.hiveId,
      this.code,
      this.seats,
      this.amount,
      this.products,
      this.craetedAt,
      this.updatedAt,
      this.tableId,
      this.orderTemp,
      this.imageBase64,
      this.userName,
      this.position,
      this.status = AppConstants.TABLE_EMPTY,
      this.timeOrder});
  TablePos copyWith(
      {String? hiveId,
      String? code,
      int? seats,
      double? amount,
      List<Product>? products,
      String? craetedAt,
      String? updatedAt,
      String? tableId,
      List<OrderItem>? orderTemp,
      String? imageBase64,
      String? userName,
      String? position,
      String? status,
      DateTime? timeOrder}) {
    return TablePos(
        hiveId: hiveId ?? this.hiveId,
        code: code ?? this.code,
        seats: seats ?? this.seats,
        amount: amount ?? this.amount,
        products: products ?? this.products,
        craetedAt: craetedAt ?? this.craetedAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tableId: tableId ?? this.tableId,
        orderTemp: orderTemp ?? this.orderTemp,
        imageBase64: imageBase64 ?? this.imageBase64,
        userName: userName ?? this.userName,
        position: position ?? this.position,
        status: status ?? this.status,
        timeOrder: timeOrder ?? this.timeOrder);
  }
}
