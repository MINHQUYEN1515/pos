import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pos/data/local_model/user_local.dart';
import 'package:uuid/uuid.dart';

import 'interface/user_service.dart';

class UserService extends IUserService {
  late final Box<UserLocal> _box;

  UserService() : _box = GetIt.I.get<Box<UserLocal>>();
  @override
  Future delete(String id) {
    return Future.value(_box.delete(id));
  }

  @override
  Future<List<UserLocal>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<UserLocal?> getById(String id) {
    return Future.value(_box.get(id));
  }

  @override
  Future<UserLocal?> insert(UserLocal entity) async {
    try {
      entity = entity.copyWith(hiveId: Uuid().v1());
      await _box.put(entity.hiveId, entity);
      return entity;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserLocal?> update(UserLocal entity) async {
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
  Future<bool> insertAll(List<UserLocal> entities) async {
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
