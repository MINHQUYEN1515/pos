import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/product.dart';
part 'table.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_TABLE)
class Table {
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
  @HiveField(7, defaultValue: 0)
  int? tableId;
  Table(
      {this.hiveId,
      this.code,
      this.seats,
      this.amount,
      this.products,
      this.craetedAt,
      this.updatedAt,
      this.tableId});
}
