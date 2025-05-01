import 'package:pos/data/local_model/order_item.dart';
import 'package:pos/data/local_model/product.dart';
import 'package:uuid/uuid.dart';

class OrderItemUtils {
  OrderItemUtils._();
  static OrderItem createOrderTemp(
      {required Product product,
      required String tableId,
      String? notes,
      String? extras,
      int? quantity,
      String? username}) {
    return OrderItem(
        hiveId: Uuid().v4(),
        tableId: tableId,
        product: product,
        note: notes,
        craetedAt: DateTime.now().toString(),
        extras: extras,
        quantity: quantity,
        username: username,
        totalAmount: quantity! * product.price!,
        updatedAt: DateTime.now().toString());
  }
}
