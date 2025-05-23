import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/app.dart';
import 'package:pos/dependencies/app_dependencies.dart';
import 'package:pos/server/server.dart';
import 'package:pos/state_manager/login_cubit/login.dart';

import 'data/database/data_base_local.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DataBaseLocal.init();
  await AppDependencies.init();
  Server.instane.initRoutes();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('vi'), Locale('de')],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale(
        'vi',
      ),
      startLocale: const Locale('vi'),
      child: ScreenUtilInit(
        designSize: Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return App(GetIt.I.get<LoginCubit>());
        },
      )));
}
