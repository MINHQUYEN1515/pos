import 'package:pos/data/local_model/product.dart';
import 'package:pos/data/repositories/interface/iproduct_repo.dart';
import 'package:pos/data/service/interface/iproduct_service.dart';
import 'package:pos/utils/logger.dart';

class ProductRepo extends IProductRepo {
  late IproductService _service;
  ProductRepo(this._service);

  @override
  Future<List<Product>> getAll() async {
    try {
      return await _service.getAll();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<bool> insertData({required Product product}) async {
    try {
      await _service.insert(product);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
