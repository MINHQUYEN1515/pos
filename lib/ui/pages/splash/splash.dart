import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/state_manager/splash_cubit/splash_cubit.dart';
import 'package:pos/ui/widgets/app_circular_progress_indicator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<SplashCubit>(),
      child: SplashPageChild(),
    );
  }
}

class SplashPageChild extends StatefulWidget {
  const SplashPageChild({super.key});

  @override
  State<SplashPageChild> createState() => _SplashPageChildState();
}

class _SplashPageChildState extends State<SplashPageChild> {
  late SplashCubit _cubit;
  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    _checkDevice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppCircularProgressIndicator(),
      ),
    );
  }

  void _checkDevice() {
    _cubit.checkDevice().then((value) {
      if (value) {
        Navigator.of(context).pushNamed(AppRoutes.login);
      } else {
        Navigator.of(context).pushNamed(AppRoutes.register);
      }
    });
  }
}
