import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';

import '../constants/app_colors.dart';
import '../global_styles/global_styles.dart';

class ButtonCustom extends StatelessWidget {
  final double? mineWidth;
  final double? mineHeight;
  final String textHint;
  final backgroundColor;
  final labelColor;
  final onFunction;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? radius;
  final FontWeight? fontWeight;
  final margin;
  final border;
  final hintColor;
  final shadowColor;

  const ButtonCustom(
      {this.mineWidth,
      this.mineHeight,
      required this.textHint,
      required this.onFunction,
      this.backgroundColor,
      this.labelColor,
      this.fontSize,
      this.padding,
      this.radius,
      this.fontWeight,
      this.margin,
      this.border,
      this.hintColor,
      this.shadowColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: mineHeight ?? 50,
          width: mineWidth,
          margin: margin ?? EdgeInsets.zero,
          child: ElevatedButton(
            onPressed: onFunction,
            child: Text(
              textHint,
              textAlign: TextAlign.center,
              style: TextStyle(color: hintColor ?? Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                foregroundColor: labelColor,
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 4),
                    side: border ??
                        BorderSide(width: 0, color: Colors.transparent)),
                padding: padding ?? EdgeInsets.fromLTRB(0, 12, 0, 12),
                shadowColor: shadowColor ?? null,
                textStyle: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: fontWeight ?? FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

class ButtonIconCustom extends StatelessWidget {
  final double? mineWidth;
  final double? mineHeight;
  final textHint;
  final backgroundColor;
  final labelColor;
  final onFunction;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? radius;
  final FontWeight? fontWeight;
  final margin;
  final icon;

  const ButtonIconCustom(
      {this.mineWidth,
      this.mineHeight,
      required this.textHint,
      required this.icon,
      required this.onFunction,
      this.backgroundColor,
      this.labelColor,
      this.fontSize,
      this.padding,
      this.radius,
      this.fontWeight,
      this.margin,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: mineHeight ?? 50,
          width: mineWidth,
          margin: margin ?? EdgeInsets.zero,
          child: ElevatedButton(
            onPressed: onFunction,
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  GlobalStyles.sizedBoxHeight_5,
                  Text(
                    textHint,
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
                foregroundColor: labelColor,
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 4)),
                padding: padding ?? EdgeInsets.fromLTRB(0, 12, 0, 12),
                textStyle: TextStyle(
                    fontSize: fontSize ?? 18,
                    fontWeight: fontWeight ?? FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

Widget CustomButton(String title, Function onPressed) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    elevation: 5.0,
    height: 45,
    minWidth: double.infinity,
    onPressed: () => onPressed(),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    ),
    color: Color(0xFFADDDFF),
  );
}
