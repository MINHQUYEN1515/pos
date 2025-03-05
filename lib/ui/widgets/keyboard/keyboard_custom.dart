import 'package:flutter/material.dart';
import 'package:pos/core/constants/colors_constants.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';

import '../button/custom_material_button.dart';
import '../textfield/app_text_field.dart';

class KeyboardCustom extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onConfirm;
  final VoidCallback? onmPayment;
  final String title;
  final BoxDecoration? decoration;
  final double? heightKey;
  final TypeKeyBoard type;
  const KeyboardCustom(
      {super.key,
      required this.controller,
      this.onConfirm,
      this.onmPayment,
      this.title = '',
      this.decoration,
      this.heightKey,
      this.type = TypeKeyBoard.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: decoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorsConstants.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, -4), // Điều chỉnh vị trí bóng
                ),
              ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title.w600(fontSize: 30),
          SizedBox(
            height: 13,
          ),
          Row(
            spacing: 5,
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  controller: controller,
                  background: appColors(context).grey,
                  textAlign: TextAlign.center,
                  fontSize: 38,
                  borderRadius: 5,
                  borderColor: appColors(context).primaryColor75,
                  isShowKeyBoard: true,
                ),
              ),
              if (type == TypeKeyBoard.payment)
                Expanded(
                    child: CustomMaterialButton(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appColors(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 90,
                        child: "Thanh toán".w600(
                            fontSize: 25, color: appColors(context).white)))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Column(
              spacing: 5,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("1");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "1".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("2");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "2".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("3");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "3".w700(fontSize: 30)),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("4");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "4".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("5");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "5".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("6");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "6".w700(fontSize: 30)),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("7");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "7".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("8");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "8".w700(fontSize: 30)),
                    ),
                    Expanded(
                      child: CustomMaterialButton(
                          onTap: () {
                            _enterPassword("9");
                          },
                          height: heightKey ?? 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).white),
                          child: "9".w700(fontSize: 30)),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Expanded(
                        child: CustomMaterialButton(
                            onTap: _removeString,
                            height: heightKey ?? 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: appColors(context).black),
                                borderRadius: BorderRadius.circular(5),
                                color: appColors(context).white),
                            child: Icon(Icons.backspace))),
                    Expanded(
                        child: CustomMaterialButton(
                            onTap: () {
                              _enterPassword("0");
                            },
                            height: heightKey ?? 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: appColors(context).black),
                                borderRadius: BorderRadius.circular(5),
                                color: appColors(context).white),
                            child: "0".w700(fontSize: 30))),
                    Expanded(
                        child: CustomMaterialButton(
                            onTap: () {
                              onConfirm?.call(controller.text);
                            },
                            height: heightKey ?? 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: appColors(context).black),
                              borderRadius: BorderRadius.circular(5),
                              color: appColors(context).primaryColor,
                            ),
                            child: "Xác nhận".w500(
                                fontSize: 25,
                                color: appColors(context).white))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _removeString() {
    if (controller.text != null && controller.text != '') {
      controller.text =
          controller.text.substring(0, controller.text.length - 1);
    }
  }

  void _enterPassword(String text) {
    controller.text = controller.text + text;
  }
}
