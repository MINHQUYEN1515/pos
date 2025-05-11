import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos/extensions/text_ext_customize.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class ModalOption extends StatelessWidget {
  final VoidCallback? onOrderFromUser;
  final VoidCallback? onTakeTableAndPay;
  final VoidCallback? onShowTable;
  const ModalOption(
      {super.key,
      this.onOrderFromUser,
      this.onShowTable,
      this.onTakeTableAndPay});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 270,
          width: 306,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          decoration: BoxDecoration(
              color: Color(0xffFEF1DA),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // màu bóng
                  spreadRadius: 2, // độ lan của bóng
                  blurRadius: 6, // độ mờ của bóng
                  offset: Offset(0, 5), // vị trí bóng: (x: ngang, y: dọc)
                ),
              ]),
          child: Column(
            spacing: 2,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              '${'please_select_option'.tr()}'.w400(
                  fontSize: 20,
                  config: TextStyleExtConfig(textAlign: TextAlign.center)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomMaterialButton(
                            onTap: () {
                              onOrderFromUser?.call();
                            },
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: appColors(context).primaryColor50),
                                color: appColors(context).white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.money),
                                '${'order_for_staff'.tr()}'.w400(
                                    fontSize: 16,
                                    color: appColors(context).primaryColor,
                                    config: TextStyleExtConfig(
                                        textAlign: TextAlign.center))
                              ],
                            )),
                      ),
                      Expanded(
                        child: CustomMaterialButton(
                            onTap: () {
                              onTakeTableAndPay?.call();
                            },
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: appColors(context).primaryColor50),
                                color: appColors(context).white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.money),
                                '${'take_table_and_pay'.tr()}'.w400(
                                    fontSize: 16,
                                    color: appColors(context).primaryColor,
                                    config: TextStyleExtConfig(
                                        textAlign: TextAlign.center))
                              ],
                            )),
                      ),
                      Expanded(
                        child: CustomMaterialButton(
                            onTap: () {
                              onShowTable?.call();
                            },
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: appColors(context).primaryColor50),
                                color: appColors(context).white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.money),
                                '${'view_table'.tr()}'.w400(
                                    fontSize: 16,
                                    color: appColors(context).primaryColor,
                                    config: TextStyleExtConfig(
                                        textAlign: TextAlign.center))
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
    ;
  }
}
