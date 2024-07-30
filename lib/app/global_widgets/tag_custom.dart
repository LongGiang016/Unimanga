import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/models/user.dart';

import '../constants/app_function.dart';
import '../constants/app_images.dart';
import '../modules/dashboard/bindings/dashboard_bindings.dart';
import '../modules/dashboard/controllers/dashboard_controllers.dart';

Widget TagWidgetItems({required int score}) {
  return Row(
    children: [
      if (score <= 100)
        WidgetItems(AppImages.bgTagLK, "Luyện Khí tầng 1")
      else if (score < 1000)
        WidgetItems(AppImages.bgTagLH, "Luyện Hư tầng 9")
      else
        WidgetItems(AppImages.bgTagDK, "Độ Kiếp Kỳ tầng 1"),
    ],
  );
}

Widget WidgetItems(String img, String name) {
  return Stack(
    children: [
      Container(
        width: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.contain,
          ),
        ),
        height: 40,
      ),
      Padding(
        padding: EdgeInsets.only(top: 15, left: 27),
        child: Text(
          "${name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 8.0,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    ],
  );
}
