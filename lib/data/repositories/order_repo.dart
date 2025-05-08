import 'package:pos/data/local_model/order.dart';
import 'package:pos/data/repositories/interface/iorder_repo.dart';
import 'package:pos/data/service/interface/iorder_service.dart';

class OrderRepo extends IOrderRepo {
  late IOrderService _service;
  OrderRepo(this._service);

  @override
  Future<List<Order>> getAll() async {
    return await _service.getAll();
  }

  @override
  Future<Order?> insert({required Order order}) async {
    return await _service.insert(order);
  }
}
