import 'package:get_it/get_it.dart';

import '../data/service/service.dart';

class ServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerLazySingleton<IAuthService>(() => AuthService());
  }
}
