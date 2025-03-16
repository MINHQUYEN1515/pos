import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/state_manager/home_cubit/home.dart';

import 'appbar.dart';

class HomePage extends StatelessWidget {
  final HomeCubit homeCubit;
  const HomePage(this.homeCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: HomePageChild(homeCubit),
    );
  }
}

class HomePageChild extends StatefulWidget {
  final HomeCubit cubit;
  const HomePageChild(this.cubit, {super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [HomeAppBar(widget.cubit)],
      ),
    );
  }
}
