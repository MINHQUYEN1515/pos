import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/text_style_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/state_manager/register_cubit/register.dart';

import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_button.dart';
import 'package:pos/ui/widgets/textfield/app_text_field.dart';
import 'package:process_run/process_run.dart';

class RegisterPage extends StatelessWidget {
  final RegisterCubit registerCubit;
  const RegisterPage(this.registerCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: registerCubit,
      child: RegisterPageChild(),
    );
  }
}

class RegisterPageChild extends StatefulWidget {
  const RegisterPageChild({super.key});

  @override
  State<RegisterPageChild> createState() => _RegisterPageChildState();
}

class _RegisterPageChildState extends State<RegisterPageChild> {
  TextEditingController _name = TextEditingController();
  late RegisterCubit _cubit;
  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
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
                  "Đăng kí thiết bị",
                  style: TextStyleConstants.textStyleBlack40,
                ),
                SizedBox(
                  height: 10,
                ),
                AppTextField(
                  controller: _name,
                  hintText: "Enter name",
                  onTap: openVirtualKeyboard,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: KeyboardCustom(
                //         heightKey: 100,
                //         controller: _name,
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
                BlocBuilder<RegisterCubit, RegisterState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return AppButton(
                      height: 100,
                      backgroundColor: appColors(context).primaryColor,
                      cornerRadius: 5,
                      title: "Xác nhận",
                      isLoading: state.status == LoadStatus.loading,
                      onPressed: () {
                        if (_name.text.isNotEmpty) {
                          _cubit.register(name: _name.text);
                          Navigator.pushNamed(context, AppRoutes.login);
                        }
                      },
                    );
                  },
                )
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
