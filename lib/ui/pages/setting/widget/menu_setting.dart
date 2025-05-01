import 'package:flutter/material.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class MenuSetting extends StatefulWidget {
  final Function(int index)? onChangeScreen;
  const MenuSetting({super.key, this.onChangeScreen});

  @override
  State<MenuSetting> createState() => _MenuSettingState();
}

class _MenuSettingState extends State<MenuSetting> {
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(1,
            title: "Cài đặt bàn",
            icons: Icon(
              Icons.table_bar,
              size: 30,
              color: appColors(context).white,
            ), callBack: () {
          setState(() {
            _index = 1;
          });
          widget.onChangeScreen?.call(_index);
        }),
        _buildButton(2,
            title: "Cài đặt món",
            icons: Icon(
              Icons.dining_sharp,
              size: 30,
              color: appColors(context).white,
            ), callBack: () {
          setState(() {
            _index = 2;
          });
          widget.onChangeScreen?.call(_index);
        }),
        _buildButton(3,
            title: "Cài đặt nhân viên",
            icons: Icon(
              Icons.people,
              size: 30,
              color: appColors(context).white,
            ), callBack: () {
          setState(() {
            _index = 3;
          });
          widget.onChangeScreen?.call(_index);
        }),
        _buildButton(4,
            title: "Cài đặt hệ thống",
            icons: Icon(
              Icons.settings_system_daydream,
              size: 30,
              color: appColors(context).white,
            ), callBack: () {
          setState(() {
            _index = 3;
          });
          widget.onChangeScreen?.call(_index);
        }),
      ],
    );
  }

  Widget _buildButton(int index,
      {required String title,
      required Icon icons,
      required VoidCallback callBack}) {
    return CustomMaterialButton(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: appColors(context).black),
            color: _index == index
                ? appColors(context).primaryColor
                : appColors(context).primaryColor75),
        onTap: () {
          callBack.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            icons,
            SizedBox(
              width: 10,
            ),
            Expanded(
                child:
                    title.w600(fontSize: 20, color: appColors(context).white)),
          ],
        ));
  }
}
