import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/setting_cubit/setting_cubit.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:pos/utils/logger.dart';

import '../../../widgets/button/custom_material_button.dart';

class ConfigProduct extends StatefulWidget {
  final SettingCubit settingCubit;
  const ConfigProduct(this.settingCubit, {super.key});

  @override
  State<ConfigProduct> createState() => _ConfigProductState();
}

class _ConfigProductState extends State<ConfigProduct> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _code = TextEditingController();
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
  void dispose() {
    _name.dispose();
    _price.dispose();
    _type.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
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
                    controller: _name,
                  )),
                  Expanded(
                      child: AppTextFieldLabel(
                    hintText: "Giá",
                    lable: "Giá",
                    hintStyle: TextStyle(color: appColors(context).grey25),
                    borderRadius: 0,
                    controller: _price,
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
                    items: ["Thức ăn", "Nước"],
                    onChange: (value) {
                      _type.text = value;
                    },
                  )),
                  Expanded(
                      child: AppTextFieldLabel(
                    lable: "Món mã",
                    borderRadius: 0,
                    controller: _code,
                  ))
                ],
              ),
              // CustomMaterialButton(
              //     onTap: () => _pickImage(),
              //     height: 70,
              //     decoration: BoxDecoration(
              //         border: Border.all(color: appColors(context).black)),
              //     child: Row(
              //       children: [
              //         IconButton(onPressed: () {}, icon: Icon(Icons.image)),
              //         Expanded(child: "Chọn hình ảnh".w600(fontSize: 30))
              //       ],
              //     ))
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: CustomMaterialButton(
                  onTap: () {
                    try {
                      double price = double.parse(_price.text);
                      widget.settingCubit.createProduct(
                          name: _name.text,
                          code: _code.text,
                          price: price,
                          type: _type.text);
                    } catch (e) {
                      AppDialog.defaultDialog(
                          message: "Vui lòng nhập đúng định dạng so ghe");
                    }
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
                      "Lưu".w400(fontSize: 20, color: appColors(context).white),
                    ],
                  )))
        ],
      ),
    );
  }
}
