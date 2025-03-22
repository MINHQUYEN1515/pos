import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:pos/utils/logger.dart';

import '../../../widgets/button/custom_material_button.dart';

class ConfigProduct extends StatefulWidget {
  const ConfigProduct({super.key});

  @override
  State<ConfigProduct> createState() => _ConfigProductState();
}

class _ConfigProductState extends State<ConfigProduct> {
  File? _image;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Allows only images
    );
    Uint8List bytes = base64Decode("");
    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
      logger.i(await _image!.writeAsBytes(bytes));
    } else {
      print("No file selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: AppTextFieldLabel(
                lable: "Tên sản phẩm",
                hintText: "Tên sản phẩm",
                hintStyle: TextStyle(color: appColors(context).grey25),
                borderRadius: 0,
              )),
              Expanded(
                  child: AppTextFieldLabel(
                hintText: "Giá",
                lable: "Giá",
                hintStyle: TextStyle(color: appColors(context).grey25),
                borderRadius: 0,
              )),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: AppDropButton(
                      borderRadius: 0,
                      height: 60,
                      lable: "Loại món ăn",
                      items: ["A"])),
              Expanded(
                  child: AppTextFieldLabel(
                lable: "Món mã",
                borderRadius: 0,
              ))
            ],
          ),
          CustomMaterialButton(
              onTap: () => _pickImage(),
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: appColors(context).black)),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                  Expanded(child: "Chọn hình ảnh".w600(fontSize: 30))
                ],
              ))
        ],
      ),
    );
  }
}
