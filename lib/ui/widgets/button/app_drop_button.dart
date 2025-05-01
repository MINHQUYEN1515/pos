import 'package:flutter/material.dart';
import 'package:pos/theme/colors.dart';

class AppDropButton extends StatefulWidget {
  final List<String> items;
  final String? lable;
  final Function(String value)? onChange;
  final double? borderRadius;
  final TextStyle? lableStyle;
  final Color? bgColor;
  final double? marginlable;
  final bool isNotLable;
  final double? height;
  final double? width;
  final double? padding;
  final Color? borderColor;
  final String? value;
  final double? fontSize;
  const AppDropButton(
      {super.key,
      required this.items,
      this.lable,
      this.onChange,
      this.borderRadius,
      this.lableStyle,
      this.bgColor,
      this.marginlable,
      this.isNotLable = false,
      this.height,
      this.width,
      this.borderColor,
      this.padding,
      this.value,
      this.fontSize});

  @override
  State<AppDropButton> createState() => _AppDropButtonState();
}

class _AppDropButtonState extends State<AppDropButton> {
  late String _currentValue;
  @override
  void initState() {
    _currentValue = widget.value!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isNotLable
            ? SizedBox()
            : Column(
                children: [
                  Text(
                    widget.lable ?? "",
                    style: widget.lableStyle ??
                        TextStyle(
                            fontSize: 18,
                            color: appColors(context).primaryColor,
                            fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: widget.marginlable ?? 0,
                  ),
                ],
              ),
        Container(
            padding: EdgeInsets.all(widget.padding ?? 10),
            width: widget.width ?? double.infinity,
            height: widget.height ?? null,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.bgColor ?? null,
                border: Border.all(
                    color:
                        widget.borderColor ?? appColors(context).primaryColor,
                    width: 1),
                borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 10))),
            child: DropdownButton<String>(
              value: _currentValue,
              focusColor: Colors.transparent,
              // isDense: true,
              underline: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: widget.fontSize ?? 25,
                          color: appColors(context).black,
                          fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
              icon: SizedBox(),
              items: widget.items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items.toUpperCase()),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _currentValue = value!;
                });
                widget.onChange?.call(value!);
              },
            ))
      ],
    );
  }
}
