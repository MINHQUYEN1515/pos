import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  const CustomMaterialButton(
      {super.key,
      required this.child,
      this.height,
      this.width,
      this.decoration,
      this.borderRadius,
      this.padding,
      this.margin,
      this.alignment,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap?.call();
          },
          borderRadius: borderRadius ?? decoration?.borderRadius?.resolve(null),
          child: Ink(
            height: height,
            width: width,
            padding: padding,
            decoration: decoration ??
                BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.transparent,
                ),
            child: alignment != null
                ? Stack(
                    children: [
                      Align(
                        alignment: alignment!,
                        child: child,
                      )
                    ],
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
