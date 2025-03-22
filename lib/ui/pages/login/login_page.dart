import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/constants/text_style_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/state_manager/login_cubit/login_cubit.dart';
import 'package:pos/theme/colors.dart';
import 'package:process_run/process_run.dart';

import '../../widgets/keyboard/keyboard_custom.dart';

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
                Row(
                  children: [
                    Expanded(
                      child: KeyboardCustom(
                        heightKey: 100,
                        controller: _password,
                        onConfirm: (value) async {
                          bool isCheck = await _cubit.login(password: value);
                          if (isCheck) {
                            Navigator.pushNamed(context, AppRoutes.home);
                          }
                        },
                        title: "Nhập password",
                        decoration: BoxDecoration(
                            color: appColors(context).white.withOpacity(0.5)),
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
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
