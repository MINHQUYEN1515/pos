import 'package:flutter/material.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/pages/setting/widget/config_product.dart';

import 'widget/config_table.dart';
import 'widget/menu_setting.dart';

class SettingPage extends StatefulWidget {
  final SettingCubit settingCubit;
  const SettingPage(this.settingCubit, {super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColors(context).white,
      child: Row(
        children: [
          Expanded(child: MenuSetting(
            onChangeScreen: (index) {
              setState(() {
                _index = index;
              });
            },
          )),
          Expanded(
            flex: 5,
            child: switch (_index) {
              1 => ConfigTable(widget.settingCubit),
              2 => ConfigProduct(),

              // TODO: Handle this case.
              int() => throw UnimplementedError(),
            },
          ),
          
        ],
      ),
    );
  }
}
