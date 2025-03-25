import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/data/local_model/product.dart';
import 'package:pos/data/service/interface/iproduct_service.dart';
import 'package:uuid/uuid.dart';

class ProductService extends IproductService {
  late final Box<Product> _box;

  ProductService() : _box = GetIt.I.get<Box<Product>>();

  @override
  Future delete(String id) {
    return Future.value(_box.delete(id));
  }

  @override
  Future<List<Product>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<Product?> getById(String id) {
    return Future.value(_box.get(id));
  }

  @override
  Future<Product?> insert(Product entity) async {
    try {
      entity = entity.copyWith(hiveId: Uuid().v1());
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> update(Product entity) async {
    try {
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await _box.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> insertAll(List<Product> entities) async {
    try {
      for (var entity in entities) {
        await insert(entity);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
