import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/filter_comic/controllers/fillter_comic_controllers.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../global_widgets/text_custom.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

class SortToStatus extends GetView<FilterController> {
  const SortToStatus({super.key, required this.text, required this.statusValue, required this.isSelected, required this.screenHeight, required this.screenWidth});
  final text;
  final statusValue;
  final isSelected;
  final screenHeight;
  final screenWidth;

  Widget build (BuildContext context) {
     return GestureDetector(
        onTap: () {
          controller.statusValue.value = statusValue;
          controller.setSelectedFilter(text);
          controller.setStatusValue(controller.statusValue.value);
        },
        child: Container(
          height: sizefix(35, screenHeight),
          width: sizefix(100, screenWidth),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.RedPrimary, width: sizefix(1, screenWidth)),
            borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
            color: isSelected ? AppColors.RedPrimary : AppColors.lightWhite,
          ),
          child: Center(
            child: TextCustom(
              text: text,
              fontsize: sizefix(12, screenHeight),
              color: isSelected ? AppColors.lightWhite : AppColors.RedPrimary,
            ),
          ),
        ),
      );
  }
}

class SortToHot extends GetView<FilterController> {
  const SortToHot ({super.key, required this.text, required this.rankValue, required this.isSelected, required this.screenHeight, required this.screenWidth});
  final text;
  final rankValue;
  final isSelected;
  final screenHeight;
  final screenWidth;

  Widget build (BuildContext context) {
    return GestureDetector(
        onTap: () {
          controller.rankValue.value = rankValue;
          controller.setSelecRankFiter(text);
        },
        child: Container(
          height: sizefix(35, screenHeight),
          width: sizefix(100, screenWidth),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.RedPrimary, width: sizefix(1, screenWidth)),
            borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
            color: isSelected ? AppColors.RedPrimary : AppColors.lightWhite,
          ),
          child: Center(
            child: TextCustom(
              text: text,
              fontsize: sizefix(12, screenHeight),
              color: isSelected ? AppColors.lightWhite : AppColors.RedPrimary,
            ),
          ),
        ),
      );
  }
}