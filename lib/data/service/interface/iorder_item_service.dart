import 'package:pos/data/local_model/order_item.dart';

import 'base_local_service.dart';

abstract class IOrderItemService extends IBaseLocalService<OrderItem> {
  Future<OrderItem?> getByProduct({required String productId});
}
