import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/text_style_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/login_cubit/login_cubit.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:process_run/process_run.dart';

class LoginPage extends StatelessWidget {
  final LoginCubit loginCubit;
  const LoginPage(this.loginCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: LoginPageChild(),
    );
  }
}

class LoginPageChild extends StatefulWidget {
  const LoginPageChild({super.key});

  @override
  State<LoginPageChild> createState() => _LoginPageChildState();
}

class _LoginPageChildState extends State<LoginPageChild> {
  late LoginCubit _cubit;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    checkLogin();
    super.initState();
  }

  void checkLogin() {
    _cubit.isLogin().then((value) {
      if (value) {
        Navigator.pushNamed(context, AppRoutes.home);
      }
      ;
    });
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(fit: BoxFit.cover, "assets/images/pos.jpg")),
          Container(
            // color: ColorsConstants.green50,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyleConstants.textStyleBlack40,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 300,
                          color: appColors(context).white,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              AppTextFieldLabel(
                                controller: _username,
                                height: 60,
                                width: double.infinity,
                                lable: "Username",
                              ),
                              AppTextFieldLabel(
                                controller: _password,
                                height: 60,
                                width: double.infinity,
                                lable: "Password",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomMaterialButton(
                                  onTap: () {
                                    if (_username.text.isEmpty ||
                                        _password.text.isEmpty) {
                                      AppDialogCustomer.showConfirmDialog(
                                          "Vui lòng nhập username và pasword");
                                    }
                                    _cubit
                                        .login(
                                            password: _password.text,
                                            username: _username.text)
                                        .then((value) {
                                      if (value) {
                                        Navigator.pushNamed(
                                            context, AppRoutes.home);
                                      } else {
                                        AppDialogCustomer.showConfirmDialog(
                                            "Username hoặc password không đúng");
                                      }
                                    });
                                  },
                                  height: 60,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: appColors(context).primaryColor),
                                  child: "Đăng nhập".w500(
                                      fontSize: 30,
                                      color: appColors(context).white))
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openVirtualKeyboard() async {
    try {
      final shell = Shell();
      // Chạy lệnh mở bàn phím ảo trên Windows
      await shell.run('osk');
    } catch (e) {
      print('Error opening virtual keyboard: $e');
    }
  }
}
