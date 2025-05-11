import 'package:get_it/get_it.dart';
import 'package:pos/state_manager/invoice_cubit/invoice.dart';
import 'package:pos/state_manager/login_cubit/login.dart';

import '../state_manager/state_manager.dart';

class BlocDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<AppCubit>(() => AppCubit());
    injector.registerFactory<HomeCubit>(
        () => HomeCubit(injector(), injector(), injector()));

    injector.registerFactory<LoginCubit>(() => LoginCubit(injector()));
    injector.registerFactory<SettingCubit>(
        () => SettingCubit(injector(), injector(), injector()));
    injector.registerFactory<TableDetailCubit>(() => TableDetailCubit(
        injector(), injector(), injector(), injector(), injector()));
    injector.registerFactory<InvoiceCubit>(
        () => InvoiceCubit(injector(), injector()));
  }
}
