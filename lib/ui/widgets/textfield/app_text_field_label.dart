import 'package:flutter/material.dart';
import 'package:pos/core/constants/colors_constants.dart';

class AppTextFieldLabel extends StatelessWidget {
  final TextEditingController? controller;
  final String? lable;
  final VoidCallback? callback;
  final double? borderRadius;
  final TextStyle? lableStyle;
  final Color? bgColor;
  final double? marginlable;
  final bool isNotLable;
  final double? height;
  final double? width;
  final double? padding;
  final Color? borderColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? fontSize;
  final String obscuringCharacter;
  final bool? obscureText;
  final int? maxLines;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final Widget? widgetPrefix;
  const AppTextFieldLabel(
      {super.key,
      this.controller,
      this.lable,
      this.callback,
      this.borderRadius,
      this.lableStyle,
      this.bgColor,
      this.marginlable,
      this.isNotLable = false,
      this.height,
      this.width,
      this.borderColor,
      this.padding,
      this.hintText,
      this.hintStyle,
      this.fontSize,
      this.obscuringCharacter = '•',
      this.obscureText,
      this.maxLines,
      this.onChanged,
      this.onTap,
      this.widgetPrefix});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      isNotLable
          ? SizedBox()
          : Column(
              children: [
                Text(
                  lable ?? "",
                  style: lableStyle ??
                      TextStyle(
                          fontSize: 18,
                          color: ColorsConstants.black,
                          fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: marginlable ?? 0,
                ),
              ],
            ),
      Container(
          // padding: EdgeInsets.all(padding ?? 10),
          width: width ?? double.infinity,
          height: height ?? null,
          padding: EdgeInsets.all(padding ?? 5),
          decoration: BoxDecoration(
              color: bgColor ?? null,
              border: Border.all(
                  color: borderColor ?? ColorsConstants.black, width: 1),
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          child: TextFormField(
            onTap: onTap,
            maxLines: maxLines,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText ?? false,
            controller: controller,
            style: TextStyle(fontSize: fontSize ?? 25),
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle ??
                    TextStyle(
                      fontSize: 30,
                      color: ColorsConstants.black,
                    ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: widgetPrefix),
            onChanged: onChanged,
          )),
    ]);
  }
}
