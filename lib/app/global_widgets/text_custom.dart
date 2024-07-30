
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

 class TextCustom extends StatelessWidget {
  final text;
  final font = AppFonts.verLag;
  final double? fontsize;
  final fontWeight;
  final color;
  final textalign;
  final int? maxline;
  final overflow;
  final decoration;
  TextCustom({required this.text,  this.fontsize, this.fontWeight, this.color, this.textalign, this.maxline, this.overflow, this.decoration});
  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: textalign, maxLines: maxline,overflow: overflow, style: TextStyle(fontFamily: AppFonts.verLag, fontSize: fontsize, fontWeight: fontWeight, color: color,decoration: decoration ),);
  }
}