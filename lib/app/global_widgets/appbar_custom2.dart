import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_images.dart';

Widget IntroWidgetWithoutLogo() {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.bgProfile), fit: BoxFit.cover)),
    height: Get.height * 0.3,
  );
}
