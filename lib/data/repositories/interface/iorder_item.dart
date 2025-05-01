import 'package:pos/data/local_model/order_item.dart';

abstract class IOrderItemRepo {
  Future<List<OrderItem>> getAll();
  Future<OrderItem?> insertData(OrderItem data);
}
