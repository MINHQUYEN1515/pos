import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';

class ConfigTable extends StatefulWidget {
  final SettingCubit settingCubit;
  const ConfigTable(this.settingCubit, {super.key});

  @override
  State<ConfigTable> createState() => _ConfigTableState();
}

class _ConfigTableState extends State<ConfigTable> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _seats = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _position = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _seats.dispose();
    _code.dispose();
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == LoadStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                spacing: 20,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: AppTextFieldLabel(
                          lable: "Tên bàn",
                          borderRadius: 0,
                          hintText: "Tên bàn",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _name,
                        ),
                      ),
                      Expanded(
                        child: AppTextFieldLabel(
                          lable: "Số ghế",
                          borderRadius: 0,
                          hintText: "Số ghế",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _seats,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: AppTextFieldLabel(
                          lable: "Mã bàn",
                          borderRadius: 0,
                          hintText: "Mã bàn",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _code,
                        ),
                      ),
                      Expanded(
                        child: AppTextFieldLabel(
                          lable: "Vị trí",
                          borderRadius: 0,
                          hintText: "Vị trí",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _position,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: CustomMaterialButton(
                      onTap: () {
                        try {
                          int seat = int.parse(_seats.text);
                          widget.settingCubit.craeteTable(
                              tableName: _name.text,
                              code: _code.text,
                              seats: seat,
                              position: _position.text);
                        } catch (e) {
                          AppDialog.defaultDialog(
                              message: "Vui lòng nhập đúng định dạng so ghe");
                        }
                      },
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                          color: appColors(context).primaryColor75,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 30,
                            color: appColors(context).white,
                          ),
                          "Lưu".w400(
                              fontSize: 20, color: appColors(context).white),
                        ],
                      )))
            ],
          ),
        );
      },
    );
  }
}
