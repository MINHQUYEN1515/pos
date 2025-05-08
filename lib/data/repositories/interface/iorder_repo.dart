import 'package:pos/data/local_model/local_model.dart';

abstract class IOrderRepo {
  Future<List<Order>> getAll();
  Future<Order?> insert({required Order order});
}
