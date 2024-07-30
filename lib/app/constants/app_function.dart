import 'package:flutter/material.dart';

abstract class ScreenUtil {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}

class Sizefix {
static double sizefix(double size, double screen) {
  double percentage = size / screen;
  double result = screen * percentage;
  return result;
}
static double sizefixall(double size, double screenWidth, double screenHeight) {
  double screen = (screenWidth + screenHeight) / 2;
  double percentage = size / 375.0; // 375.0 là kích thước chuẩn mà bạn đã thiết kế
  double result = screen * percentage;
  return result;
}
}