import 'package:flutter/material.dart';

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:pos/ui/widgets/button/app_button.dart';

class AppDialog {
  static void defaultDialog({
    String title = "Thông báo",
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      radius: 10,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          "$message \n",
          textAlign: TextAlign.center,
        ),
      ),
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirm: (textConfirm ?? "").isEmpty
          ? null
          : AppButton(
              cornerRadius: 5,
              height: 50,
              width: 100,
              backgroundColor: const Color.fromARGB(255, 238, 145, 138),
              title: textConfirm ?? "",
              onPressed: () {
                Get.back();
                onConfirm?.call();
              },
            ),
      cancel: (textCancel ?? "").isEmpty
          ? null
          : AppButton(
              cornerRadius: 5,
              height: 50,
              width: 100,
              backgroundColor: const Color.fromARGB(255, 148, 197, 237),
              title: textCancel ?? "",
              onPressed: () {
                Get.back();
                onCancel?.call();
              },
            ),
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
    );
  }
}
