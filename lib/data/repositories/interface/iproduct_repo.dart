import 'package:pos/data/local_model/local_model.dart';

abstract class IProductRepo {
  Future<List<Product>> getAll();
  Future<bool> insertData({required Product product});
}
