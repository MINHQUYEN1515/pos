import 'package:pos/data/local_model/local_model.dart';

abstract class IProductRepo {
  Future<List<Product>> getAll();
  Future<Product?> insertData({required Product product});
  Future<bool> delete({required String hiveId});
  Future<bool> updateProduct({required Product product});
}
