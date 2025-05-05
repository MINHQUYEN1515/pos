import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:pos/utils/logger.dart';

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
  Permission? _value;
  bool _isShowPassword = false;
  @override
  void initState() {
    _value = Permission.user;
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
          child: Column(
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
                      hintStyle: TextStyle(color: appColors(context).grey25),
                      controller: _username,
                    ),
                  ),
                  Expanded(
                    child: AppTextFieldLabel(
                      lable: "Password",
                      borderRadius: 0,
                      hintText: "Password",
                      hintStyle: TextStyle(color: appColors(context).grey25),
                      controller: _password,
                      obscureText: _isShowPassword,
                      maxLines: 1,
                      widgetPrefix: IconButton(
                          onPressed: () {
                            setState(() {
                              _isShowPassword = !_isShowPassword;
                            });
                          },
                          icon: Icon(_isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off)),
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
                      items: Permission.values
                          .map((e) => e.toString().split('.').last)
                          .toList(),
                      lable: "Vai trò",
                      borderRadius: 0,
                      value: _value!.name.toString(),
                      onChange: (value) {
                        _value = Permission.values.byName(value);
                        logger.i(_value);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                children: [
                  "DANH SÁCH NHÂN VIÊN".w600(fontSize: 40),
                  Container(
                    height: 60,
                    child: Row(
                      spacing: 10,
                      children: [
                        SizedBox(width: 20),
                        Expanded(child: "Username".w600(fontSize: 20)),
                        Expanded(child: "Quyền".w600(fontSize: 20)),
                        SizedBox(
                          width: 150,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<SettingCubit, SettingState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final user = state.users[index];
                                    return _buildUser(
                                        user: user,
                                        onDelete: () {
                                          widget.settingCubit
                                              .deleteUser(hiveId: user.hiveId!);
                                        });
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(),
                                  itemCount: state.users.length);
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomMaterialButton(
                    onTap: () {
                      UserLocal user = UserLocal(
                          username: _username.text,
                          password: _password.text,
                          permission: _value);
                      widget.settingCubit.createUser(user: user).then((value) {
                        _username.text = '';
                        _password.text = '';
                      });
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
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  _buildUser(
      {required UserLocal user, VoidCallback? onEdit, VoidCallback? onDelete}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: appColors(context).grey)),
      height: 60,
      child: Row(
        spacing: 10,
        children: [
          SizedBox(width: 20, child: Icon(Icons.person)),
          Expanded(child: user.username!.w400(fontSize: 20)),
          Expanded(child: user.permission!.name.w400(fontSize: 20)),
          SizedBox(
            width: 150,
            child: Row(
              spacing: 10,
              children: [
                IconButton(
                    onPressed: () {
                      onEdit?.call();
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      onDelete?.call();
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          )
        ],
      ),
    );
  }
}
