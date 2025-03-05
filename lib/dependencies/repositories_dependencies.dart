import 'package:get_it/get_it.dart';

import '../data/repositories/repo.dart';

class RepositoriesDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton<IAuthRepo>(() => AuthRepo(injector()));
  }
}
