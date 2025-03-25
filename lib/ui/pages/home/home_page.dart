import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/state_manager/home_cubit/home.dart';
import 'package:pos/state_manager/setting_cubit/setting_cubit.dart';
import 'package:pos/ui/pages/setting/setting_page.dart';

import 'appbar.dart';
import 'home_body.dart';

class HomePage extends StatelessWidget {
  final HomeCubit homeCubit;
  final SettingCubit settingCubit;
  const HomePage(this.homeCubit, this.settingCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: homeCubit,
        ),
        BlocProvider.value(
          value: settingCubit,
        ),
      ],
      child: HomePageChild(homeCubit, settingCubit),
    );
  }
}

class HomePageChild extends StatefulWidget {
  final HomeCubit cubit;
  final SettingCubit settingCubit;
  const HomePageChild(this.cubit, this.settingCubit, {super.key});

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
        children: [
          HomeAppBar(widget.cubit),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => previous.screen != current.screen,
            builder: (context, state) {
              if (state.screen == Screen.setting) {
                return Expanded(child: SettingPage(widget.settingCubit));
              }
              return Expanded(child: HomeBody(widget.cubit));
            },
          )
        ],
      ),
    );
  }
}
