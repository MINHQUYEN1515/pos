import 'package:flutter/material.dart';
import 'package:pos/state_manager/splash_cubit/splash_cubit.dart';
import 'package:pos/ui/widgets/app_circular_progress_indicator.dart';

class SplashPage extends StatelessWidget {
  final SplashCubit? splashCubit;
  const SplashPage({super.key, this.splashCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppCircularProgressIndicator(),
      ),
    );
  }
}
