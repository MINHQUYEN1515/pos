import 'package:pos/data/local_model/local_model.dart';
import 'package:uuid/uuid.dart';

class OrderUtils {
  static Order createOrder(
      {required List<OrderItem> orderTemp,
      String? username,
      required String pay}) {
    double _price = 0;
    orderTemp.forEach((e) {
      _price += e.product!.price!;
      e.product?.extras?.forEach((el) {
        _price += el.price;
      });
    });
    return Order(
        hiveId: Uuid().v1(),
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        items: orderTemp,
        payment: pay,
        total: _price,
        amount: _price,
        username: username);
  }
}
