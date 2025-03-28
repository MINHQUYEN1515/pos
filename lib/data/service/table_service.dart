import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/data/local_model/table.dart';
import 'package:pos/data/service/interface/table_service.dart';
import 'package:uuid/uuid.dart';

class TableService extends ITableService {
  late final Box<TablePos> _box;

  TableService() : _box = GetIt.I.get<Box<TablePos>>();

  @override
  Future delete(String id) {
    return Future.value(_box.delete(id));
  }

  @override
  Future<List<TablePos>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<TablePos?> getById(String id) {
    return Future.value(_box.get(id));
  }

  @override
  Future<TablePos?> insert(TablePos entity) async {
    try {
      entity = entity.copyWith(hiveId: Uuid().v1());
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<TablePos?> update(TablePos entity) async {
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
  Future<bool> insertAll(List<TablePos> entities) async {
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
