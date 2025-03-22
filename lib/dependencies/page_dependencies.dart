import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/ui/pages/page.dart';
import 'package:pos/ui/pages/splash/splash.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => SplashPage(),
        instanceName: AppRoutes.splash);
    injector.registerFactory<Widget>(() => RegisterPage(injector()),
        instanceName: AppRoutes.register);
    injector.registerFactory<Widget>(() => HomePage(injector(), injector()),
        instanceName: AppRoutes.home);
    injector.registerFactory<Widget>(() => LoginPage(injector()),
        instanceName: AppRoutes.login);
  }
}
