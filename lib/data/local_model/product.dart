import 'package:hive_flutter/adapters.dart';

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
  @HiveField(3, defaultValue: '')
  String? type;
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
  Product copyWith({
    String? hiveId,
    String? name,
    double? price,
    String? type,
    String? code,
    String? image,
    String? craetedAt,
    String? updatedAt,
  }) {
    return Product(
      hiveId: hiveId ?? this.hiveId,
      name: name ?? this.name,
      price: price ?? this.price,
      type: type ?? this.type,
      code: code ?? this.code,
      image: image ?? this.image,
      craetedAt: craetedAt ?? this.craetedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
