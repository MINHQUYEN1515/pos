import 'package:get_it/get_it.dart';
import 'package:pos/data/repositories/interface/table_repo.dart';
import 'package:pos/data/repositories/product_repo.dart';

import '../data/repositories/repo.dart';

class RepositoriesDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<IAuthRepo>(() => AuthRepo(injector(), injector()));
    injector.registerFactory<ITableRepo>(() => TableRepo(injector()));
    injector.registerFactory<IProductRepo>(() => ProductRepo(injector()));
  }
}
