import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/permission.dart';
import 'package:pos/state_manager/home_cubit/home.dart';
import 'package:pos/state_manager/setting_cubit/setting_cubit.dart';
import 'package:pos/state_manager/table_detail/table_detail_cubit.dart';
import 'package:pos/ui/pages/merge_table/merge_table.dart';
import 'package:pos/ui/pages/setting/setting_page.dart';

import '../change_table/change_table.dart';
import 'appbar.dart';
import 'home_body.dart';

class HomePage extends StatelessWidget {
  final HomeCubit homeCubit;
  final SettingCubit settingCubit;
  final TableDetailCubit tableCubit;
  const HomePage(this.homeCubit, this.settingCubit, this.tableCubit,
      {super.key});

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
        BlocProvider.value(value: tableCubit)
      ],
      child: HomePageChild(homeCubit, settingCubit, tableCubit),
    );
  }
}

class HomePageChild extends StatefulWidget {
  final HomeCubit cubit;
  final SettingCubit settingCubit;
  final TableDetailCubit tableCubit;
  const HomePageChild(this.cubit, this.settingCubit, this.tableCubit,
      {super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  int? _select;
  @override
  void initState() {
    _select = widget.cubit.user?.permission == Permission.admin ? 5 : 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppBar(
            select: _select,
            widget.cubit,
            onChangeTable: () {
              showRightModal(context);
            },
            onMergeTable: () {
              showRightModalMer(context);
            },
            onEmitIndex: (value) {
              setState(() {
                _select = value;
              });
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => previous.screen != current.screen,
            builder: (context, state) {
              if (state.screen == Screen.setting) {
                return Expanded(child: SettingPage(widget.settingCubit));
              }
              return Expanded(child: HomeBody(widget.cubit, widget.tableCubit));
            },
          )
        ],
      ),
    );
  }

  void showRightModal(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 100,
        right: 0,
        child: Material(
            elevation: 12,
            color: Colors.transparent,
            child: ChangeTableKey(
              widget.tableCubit,
              widget.cubit,
              onClose: () {
                setState(() {
                  entry.remove();
                  _select = 2;
                });
              },
            )),
      ),
    );

    overlay.insert(entry);
  }

  void showRightModalMer(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => Positioned(
        top: 100,
        right: 0,
        child: Material(
            elevation: 12,
            color: Colors.transparent,
            child: MergeTableKey(
              widget.tableCubit,
              widget.cubit,
              onClose: () {
                setState(() {
                  entry.remove();
                  _select = 2;
                });
              },
            )),
      ),
    );

    overlay.insert(entry);
  }
}
