import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/ui/pages/page.dart';

class PageDependencies {
  static Future setup(GetIt injector) async {
    injector.registerFactory<Widget>(
        () => HomePage(injector(), injector(), injector(), injector()),
        instanceName: AppRoutes.home);
    injector.registerFactory<Widget>(() => LoginPage(injector()),
        instanceName: AppRoutes.login);
    injector.registerCachedFactory<Widget>(
        () => TableDetail(injector(), injector()),
        instanceName: AppRoutes.tableDetai);
    injector.registerFactory<Widget>(() => InvoiceListScreen(injector()));
  }
}
