import 'package:pos/data/local_model/order_item.dart';
import 'package:pos/data/repositories/interface/iorder_item.dart';
import 'package:pos/data/service/interface/iorder_item_service.dart';
import 'package:pos/utils/logger.dart';

class OrderItemRepo extends IOrderItemRepo {
  late IOrderItemService _service;
  OrderItemRepo(this._service);
  @override
  Future<List<OrderItem>> getAll() async {
    try {
      return await _service.getAll();
    } catch (e) {
      logger.e(e);
    }
    return [];
  }

  @override
  Future<OrderItem?> insertData(OrderItem data) async {
    try {
      return await _service.insert(data);
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  @override
  Future<OrderItem?> findOrder({required String productId}) async {
    return await _service.getByProduct(productId: productId);
  }

  @override
  Future<OrderItem?> updateOrder({required OrderItem order}) async {
    await _service.update(order);
    return null;
  }

  @override
  Future<bool> deleteOrder({required OrderItem order}) async {
    try {
      await _service.delete(order.hiveId!);
      return true;
    } catch (e) {
      return false;
    }
  }
}
