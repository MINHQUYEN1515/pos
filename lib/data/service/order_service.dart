import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pos/data/local_model/order.dart';
import 'package:pos/data/service/interface/iorder_service.dart';
import 'package:pos/utils/logger.dart';
import 'package:uuid/uuid.dart';

class OrderService extends IOrderService {
  late final Box<Order> _box;

  OrderService() : _box = GetIt.I.get<Box<Order>>();

  @override
  Future delete(String id) {
    return Future.value(_box.delete(id));
  }

  @override
  Future<List<Order>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<Order?> getById(String id) {
    return Future.value(_box.get(id));
  }

  @override
  Future<Order?> insert(Order entity) async {
    try {
      entity.hiveId = Uuid().v1();
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  @override
  Future<Order?> update(Order entity) async {
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
  Future<bool> insertAll(List<Order> entities) async {
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
