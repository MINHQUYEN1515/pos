import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/constants/colors_constants.dart';

class TextStyleConstants {
  //******************************BLACK******************** */
  static const TextStyle textStyleBlack = TextStyle(
    color: ColorsConstants.black,
  );
  static TextStyle textStyleBlack12 = textStyleBlack.copyWith(fontSize: 12);
  static TextStyle textStyleBlack14 = textStyleBlack.copyWith(fontSize: 14);
  static TextStyle textStyleBlack16 = textStyleBlack.copyWith(fontSize: 16);
  static TextStyle textStyleBlack18 = textStyleBlack.copyWith(fontSize: 18);
  static TextStyle textStyleBlack40 = textStyleBlack.copyWith(fontSize: 40.sp);
}
