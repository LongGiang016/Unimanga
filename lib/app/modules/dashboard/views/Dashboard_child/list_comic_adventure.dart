import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/text_custom.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../constants/app_images.dart';
import '../../../../global_widgets/comic_items.dart';
import '../../../filter_comic/controllers/fillter_comic_controllers.dart';
import '../../../filter_comic/views/fillter_comic_views.dart';
import '../../bindings/dashboard_bindings.dart';
import '../../controllers/dashboard_controllers.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class ListComicAdventure extends GetView<FilterController> {
  const ListComicAdventure({super.key, required this.screenHeight, required this.screenWidth});
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context){
    //final filterController = Get.find<FilterController>(); 
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizefix(22, screenHeight),
              width: sizefix(22, screenHeight),
              child: Image.asset(AppImages.icAction),
            ),
            SizedBox(width: sizefix(5, screenWidth),),
            GestureDetector(
              onTap: (){
                controller.rankValue.value = 0;
                controller.selectedFilter.value = "Tất cả";
                controller.selectedRankFilter.value = "Ngày cập nhật";
                controller.setCategoryFilter("Adventure");
                Get.to(() => FilterComicView());
              },
              child: TextCustom(
                text: "Truyện phưu lưu",
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontsize: sizefix(15, screenWidth),
              ),
            ),
            
          ],
        ),
        SizedBox(height: sizefix(15, screenHeight)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListComicAdventurechild(),
        ),
      ],
    );
  }
}

class ListComicAdventurechild extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    return Obx(() {
      var listComicAction = controller.listcomicAdVenture.value;
      // Giới hạn số lượng item
      int itemCount = listComicAction.length > 5 ? 5 : listComicAction.length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < itemCount; i++)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ComicItems(
                comic: listComicAction[i],
                cateList: 0,
              ),
            ),
        ],
      );
    });
  }
}