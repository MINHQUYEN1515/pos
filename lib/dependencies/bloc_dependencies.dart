import 'package:get_it/get_it.dart';
import 'package:pos/state_manager/splash_cubit/splash_cubit.dart';

import '../state_manager/state_manager.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<AppCubit>(() => AppCubit());
    injector.registerFactory<HomeCubit>(() => HomeCubit());
    injector.registerFactory<RegisterCubit>(() => RegisterCubit(injector()));
    injector.registerFactory<SplashCubit>(() => SplashCubit());
  }
}
