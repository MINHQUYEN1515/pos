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
  factory Extra.fromJson(Map<String, dynamic> json) {
    return Extra(
      hiveId: json['hiveId'],
      name: json['name'],
      price: json['price']?.toDouble() ?? 0.0, // Default to 0 if null
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      quantity: json['quantity'] ?? 1, // Default to 1 if null
      total: json['total']?.toDouble() ?? 0.0, // Default to 0 if null
    );
  }
  Extra(
      {this.hiveId,
      this.name,
      this.price = 0,
      this.createdAt,
      this.quantity = 1,
      this.total = 0});
  Map<String, dynamic> toJson() {
    return {
      'hiveId': hiveId,
      'name': name,
      'price': price,
      'createdAt':
          createdAt?.toIso8601String(), // Convert DateTime to ISO string
      'quantity': quantity,
      'total': total,
    };
  }
}
