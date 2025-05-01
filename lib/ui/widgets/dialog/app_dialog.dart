import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/extensions/text_ext_customize.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class AppDialogCustomer {
  static void showConfirmDialog(String message) {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              // padding: EdgeInsets.all(16),
              height: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration:
                        BoxDecoration(color: appColors(context).primaryColor),
                    child: '${'notification'.tr()}'
                        .w400(fontSize: 25, color: appColors(context).white),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: message.w400(
                          fontSize: 20,
                          config:
                              TextStyleExtConfig(textAlign: TextAlign.center)),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  static Future showDefaultDialog(String message,
      {VoidCallback? onClose, VoidCallback? onConfirm}) async {
    await showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Container(
              // padding: EdgeInsets.all(16),
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration:
                        BoxDecoration(color: appColors(context).primaryColor),
                    child: '${'notification'.tr()}'
                        .w400(fontSize: 25, color: appColors(context).white),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: message.w400(
                          fontSize: 20,
                          config:
                              TextStyleExtConfig(textAlign: TextAlign.center)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      spacing: 5,
                      children: [
                        Expanded(
                            child: CustomMaterialButton(
                                onTap: () async {
                                  onClose?.call();
                                  Navigator.pop(context);
                                },
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: appColors(context).primaryColor75),
                                child: '${'cancel'.tr()}'.w500(
                                    fontSize: 20,
                                    color: appColors(context).white))),
                        Expanded(
                            child: CustomMaterialButton(
                                onTap: () {
                                  onConfirm?.call();
                                  Navigator.pop(context);
                                },
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: appColors(context).primaryColor50),
                                child: '${'confirmed'.tr()}'.w500(
                                    fontSize: 20,
                                    color: appColors(context).white))),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  static void closeAll() {
    Navigator.of(navigatorKey.currentState!.overlay!.context)
        .popUntil((route) => route.isFirst);
  }
}
