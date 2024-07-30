import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_function.dart';
import '../models/category_comic_model.dart';
import '../modules/filter_comic/controllers/fillter_comic_controllers.dart';
import 'text_custom.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

class CategoryComicItem extends GetView<FilterController> {
  const CategoryComicItem({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.cate,
  });

  final double screenWidth;
  final double screenHeight;
  final categoryComicModel cate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
      height: sizefix(22, screenHeight),
      child: Row(
        children: [
          Obx(() {
            return Checkbox(
              value: controller.selectedCategories.contains(cate),
              onChanged: (bool? value) {
                if (value == true) {
                  controller.selectedCategories.add(cate);
                } else {
                  controller.selectedCategories.remove(cate);
                }
              },
              activeColor: AppColors.RedPrimary,
              checkColor: AppColors.lightWhite,
            );
          }),
          Expanded(
            child: TextCustom(
              text: cate.tenTheLoai,
              color: AppColors.RedPrimary,
              fontsize: sizefix(12, screenWidth),
            ),
          ),
        ],
      ),
    );
  }
}