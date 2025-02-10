import 'package:hive_flutter/adapters.dart';
import 'package:pos/core/constants/enum.dart';

import '../../core/constants/local_constants.dart';

part 'product.g.dart';

@HiveType(typeId: LocalConstants.ID_TABLE_PRODUCT)
class Product {
  @HiveField(0, defaultValue: '')
  String? hiveId;
  @HiveField(1, defaultValue: '')
  String? name;
  @HiveField(2, defaultValue: 0)
  double? price;
  @HiveField(3, defaultValue: TypeProduct.food)
  TypeProduct? type;
  @HiveField(4, defaultValue: '')
  String? code;
  @HiveField(5, defaultValue: '')
  String? image;
  @HiveField(6, defaultValue: '')
  String? craetedAt;
  @HiveField(7, defaultValue: '')
  String? updatedAt;
  Product(
      {this.hiveId,
      this.name,
      this.price,
      this.type,
      this.code,
      this.image,
      this.craetedAt,
      this.updatedAt});
}
