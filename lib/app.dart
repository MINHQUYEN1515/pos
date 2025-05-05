import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/state_manager/login_cubit/login.dart';
import 'package:pos/ui/pages/page.dart';

import 'core/constants/local_constants.dart';

class App extends StatefulWidget {
  final LoginCubit loginCubit;
  const App(this.loginCubit, {super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: AppRoutes.login,
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
      home: Scaffold(body: LoginPage(widget.loginCubit)),
    );
  }
}
