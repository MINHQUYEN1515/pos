import 'package:pos/data/local_model/order_item.dart';

class OrderTempRequest {
  final OrderItem orderItem;
  final int position;
  final String tableId;

  OrderTempRequest(
      {required this.orderItem, required this.position, required this.tableId});

  factory OrderTempRequest.fromJson(Map<String, dynamic> json) {
    return OrderTempRequest(
        orderItem: OrderItem.fromJson(json['order_temp']),
        position: json['position'],
        tableId: json['table_id']);
  }
}
