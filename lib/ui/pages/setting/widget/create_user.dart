import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';

import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';

class CreateUser extends StatefulWidget {
  final SettingCubit settingCubit;
  const CreateUser(this.settingCubit, {super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _type = TextEditingController();

  @override
  void initState() {
    widget.settingCubit.loadUser();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _type.dispose();
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
                          lable: "Tên nhân viên",
                          borderRadius: 0,
                          hintText: "Tên nhân viên",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _username,
                        ),
                      ),
                      Expanded(
                        child: AppTextFieldLabel(
                          lable: "Password",
                          borderRadius: 0,
                          hintText: "Password",
                          hintStyle:
                              TextStyle(color: appColors(context).grey25),
                          controller: _password,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: AppDropButton(
                          height: 60,
                          items: ['Admin', "Employee", "Cash"],
                          lable: "Vai trò",
                          borderRadius: 0,
                          value: "Admin",
                          onChange: (value) {},
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
                      onTap: () {},
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
