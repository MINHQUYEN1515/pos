import 'package:flutter/material.dart';
import 'package:pos/core/constants/colors_constants.dart';
import 'package:pos/ui/widgets/app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool isLoading;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;

  final TextStyle? textStyle;

  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderWidth,
    this.cornerRadius,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 18,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 15),
          ),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          padding: const EdgeInsets.all(0),
          backgroundColor: backgroundColor ?? Colors.white,
        ),
        onPressed: () {
          // Utils.hideKeyboard(context);
          onPressed?.call();
        },
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return AppCircularProgressIndicator(
        color: backgroundColor == null ? ColorsConstants.black : Colors.white,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          title != null
              ? Text(
                  title!,
                  style: textStyle ??
                      const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                )
              : Container(),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
