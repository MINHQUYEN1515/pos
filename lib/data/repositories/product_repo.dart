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
  Future<Product?> insertData({required Product product}) async {
    try {
      return await _service.insert(product);
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  @override
  Future<bool> delete({required String hiveId}) async {
    try {
      return await _service.delete(hiveId);
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  @override
  Future<bool> updateProduct({required Product product}) async {
    try {
      await _service.update(product);
      return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
