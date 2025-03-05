import 'package:flutter/material.dart';
import 'package:pos/core/constants/text_style_constants.dart';
import 'package:pos/state_manager/register_cubit/register.dart';

import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_button.dart';
import 'package:pos/ui/widgets/textfield/app_text_field.dart';
import 'package:process_run/process_run.dart';

class RegisterPage extends StatefulWidget {
  final RegisterCubit cubit;
  const RegisterPage(this.cubit, {super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                "Đăng kí thiết bị",
                style: TextStyleConstants.textStyleBlack40,
              ),
              SizedBox(
                height: 10,
              ),
              AppTextField(
                hintText: "Enter name",
                onTap: openVirtualKeyboard,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: KeyboardCustom(
              //         heightKey: 100,
              //         controller: _password,
              //         onConfirm: (value) {},
              //         title: "Nhập password",
              //         decoration: BoxDecoration(
              //             color: appColors(context).white.withOpacity(0.5)),
              //       ),
              //     ),
              //     Expanded(child: SizedBox())
              //   ],
              // ),
              SizedBox(
                height: 30,
              ),
              AppButton(
                height: 100,
                backgroundColor: appColors(context).primaryColor,
                cornerRadius: 5,
                title: "Xác nhận",
                onPressed: () {},
              )
            ],
          ),
        ),
      ],
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
