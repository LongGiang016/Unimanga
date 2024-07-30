import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../global_widgets/text_custom.dart';
import '../../../../models/chap_comic.dart';
import '../../../../models/comic_model.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChappterTop extends GetView<ChapterController> {
  ChappterTop({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.chapComicModel,
    this.comic,
  });

  final double screenWidth;
  final double screenHeight;
  final ChapComicModel chapComicModel;
  ComicModel? comic;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth,
      height: sizefix(60, screenHeight),
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: sizefix(10, screenHeight),
          left: sizefix(10, screenHeight),
          right: sizefix(10, screenHeight),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                controller.isUpdated.value = false;
              },
              child: Icon(Icons.arrow_back_ios, size: sizefix(15, screenHeight)),
            ),
            Padding(
              padding: EdgeInsets.only(left: sizefix(10, screenHeight)),
              child: TextCustom(
                text: "${chapComicModel.tenChuong}",
                fontsize: sizefix(15, screenHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
