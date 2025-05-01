import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:pos/core/constants/local_constants.dart';

import '../data/local_model/local_model.dart';

class DatabaseDependencies {
  static Future setup(GetIt injector) async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    _registerHiveAdapters(injector);
    await _registerHiveBoxs(injector);
  }

  static _registerHiveBoxs(GetIt injector) async {
    final billBox = await Hive.openBox<Bill>(LocalConstants.TABLE_BILL);
    final orderItemBox =
        await Hive.openBox<OrderItem>(LocalConstants.TABLE_ORDER_ITEM);
    final orderBox = await Hive.openBox<Order>(LocalConstants.TABLE_ORDER);
    final productBox =
        await Hive.openBox<Product>(LocalConstants.TABLE_PRODUCT);
    final tableBox = await Hive.openBox<TablePos>(LocalConstants.TABLE_TABLE);
    final extraTable = await Hive.openBox<Extra>(LocalConstants.TABLE_EXTRA);
    final userBox = await Hive.openBox<UserLocal>(LocalConstants.TABLE_USER);
    injector.registerLazySingleton<Box<Bill>>(() => billBox);
    injector.registerLazySingleton<Box<OrderItem>>(() => orderItemBox);
    injector.registerLazySingleton<Box<Order>>(() => orderBox);
    injector.registerLazySingleton<Box<Product>>(() => productBox);
    injector.registerLazySingleton<Box<TablePos>>(() => tableBox);
    injector.registerLazySingleton<Box<Extra>>(() => extraTable);
    injector.registerLazySingleton<Box<UserLocal>>(() => userBox);
    await userBox.put(UserLocal.sample().hiveId, UserLocal.sample());
  }

  static void _registerHiveAdapters(GetIt injector) {
    Hive.registerAdapter(BillAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(OrderItemAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(TablePosAdapter());
    Hive.registerAdapter(ExtraAdapter());
    Hive.registerAdapter(UserLocalAdapter());
    Hive.registerAdapter(PermissionAdapter());
  }
}
