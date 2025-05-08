import 'package:get_it/get_it.dart';

import '../data/service/service.dart';

class ServiceDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<IAuthService>(
        () => AuthService(injector(), injector()));
    injector.registerFactory<ITableService>(() => TableService());
    injector.registerFactory<IproductService>(() => ProductService());
    injector.registerFactory<IOrderItemService>(() => OrderItemService());
    injector.registerFactory<IUserService>(() => UserService());
    injector.registerFactory<IOrderService>(() => OrderService());
  }
}
