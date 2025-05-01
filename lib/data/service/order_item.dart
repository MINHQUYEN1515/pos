import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/data/local_model/order_item.dart';
import 'package:pos/data/service/interface/iorder_item_service.dart';
import 'package:uuid/uuid.dart';

class OrderItemService extends IOrderItemService {
  late final Box<OrderItem> _box;

  OrderItemService() : _box = GetIt.I.get<Box<OrderItem>>();

  @override
  Future delete(String id) {
    return Future.value(_box.delete(id));
  }

  @override
  Future<List<OrderItem>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<OrderItem?> getById(String id) {
    return Future.value(_box.get(id));
  }

  @override
  Future<OrderItem?> insert(OrderItem entity) async {
    try {
      entity = entity.copyWith(hiveId: Uuid().v1());
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<OrderItem?> update(OrderItem entity) async {
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
  Future<bool> insertAll(List<OrderItem> entities) async {
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
