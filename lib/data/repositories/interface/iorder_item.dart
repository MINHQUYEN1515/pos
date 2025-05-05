import 'package:pos/data/local_model/order_item.dart';

abstract class IOrderItemRepo {
  Future<List<OrderItem>> getAll();
  Future<OrderItem?> insertData(OrderItem data);
  Future<OrderItem?> findOrder({required String productId});
  Future<OrderItem?> updateOrder({required OrderItem order});
  Future<bool> deleteOrder({required OrderItem order});
}
