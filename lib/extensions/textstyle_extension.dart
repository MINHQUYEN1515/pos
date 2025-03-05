import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pos/extensions/text_ext_customize.dart';

extension TextStyleExtensions on String {
  TextExtCustomize w100(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w100style(color: color, style: style),
    );
  }

  TextSpan w100span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w100style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w100style({Color? color, double fontSize = 14, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w100,
            color: color,
            height: 1)
        .merge(style);
  }

  TextExtCustomize w200(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w200style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextSpan w200span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w200style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w200style({Color? color, double fontSize = 14, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w200,
            color: color,
            height: 1)
        .merge(style);
  }

  TextExtCustomize w300(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w300style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextSpan w300span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w300style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w300style({Color? color, double fontSize = 14, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
            color: color,
            height: 1)
        .merge(style);
  }

  TextExtCustomize w400(
      {Color? color,
      double fontSize = 14,
      double height = 1,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w400style(
        color: color,
        fontSize: fontSize,
        style: style,
        height: height,
      ),
    );
  }

  TextSpan w400span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w400style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w400style(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      double height = 1}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: color,
            height: height)
        .merge(style);
  }

  TextExtCustomize w500(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w500style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextSpan w500span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      FontStyle fontStyle = FontStyle.normal,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w500style(
          color: color, fontSize: fontSize, style: style, fontStyle: fontStyle),
    );
  }

  TextStyle? w500style(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      FontStyle fontStyle = FontStyle.normal}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            fontStyle: fontStyle,
            color: color,
            height: 1)
        .merge(style);
  }

  TextExtCustomize w600(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      double height = 1.0,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w600style(
          color: color, fontSize: fontSize, style: style, height: height),
    );
  }

  TextSpan w600span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w600style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w600style(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      double height = 1}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: color,
            height: height)
        .merge(style);
  }

  TextExtCustomize w700(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w700style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextSpan w700span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w700style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w700style({Color? color, double fontSize = 14, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: color,
            height: 1)
        .merge(style);
  }

  TextExtCustomize w800(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      TextStyleExtConfig? config}) {
    return TextExtCustomize(
      this,
      config: config,
      style: w800style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextSpan w800span(
      {Color? color,
      double fontSize = 14,
      TextStyle? style,
      List<TextSpan>? child,
      GestureRecognizer? recognizer}) {
    return TextSpan(
      text: this,
      children: child,
      recognizer: recognizer,
      style: w800style(color: color, fontSize: fontSize, style: style),
    );
  }

  TextStyle? w800style({Color? color, double fontSize = 14, TextStyle? style}) {
    return TextStyle(
            fontFamily: 'AlumniSans',
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: color,
            height: 1)
        .merge(style);
  }
}
