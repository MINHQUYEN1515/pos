import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/state_manager/register_cubit/register.dart';
import 'package:pos/ui/pages/splash/splash.dart';

class App extends StatefulWidget {
  final RegisterCubit registerCubit;
  const App(this.registerCubit, {super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) => AppRoutes.getRoute(settings),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        textTheme: GoogleFonts.oswaldTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      builder: (context, child) {
        return child!;
      },
      home: Scaffold(body: SplashPage()),
    );
  }
}
