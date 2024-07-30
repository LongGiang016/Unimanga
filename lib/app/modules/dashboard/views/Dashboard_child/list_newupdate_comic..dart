import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/text_custom.dart';
import 'package:unimanga_app/app/modules/filter_comic/controllers/fillter_comic_controllers.dart';
import 'package:unimanga_app/app/modules/filter_comic/views/fillter_comic_views.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../constants/app_images.dart';
import '../../../../global_widgets/comic_items.dart';
import '../../bindings/dashboard_bindings.dart';
import '../../controllers/dashboard_controllers.dart';


double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class ListComicNewUpdate extends GetView<FilterController> {
  const ListComicNewUpdate(
      {super.key, required this.screenHeight, required this.screenWidth});
  final double screenWidth;
  final double screenHeight;
  
  @override
  Widget build(BuildContext context) {
   //final filterController = Get.find<FilterController>();  
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: sizefix(22, screenHeight),
                  width: sizefix(22, screenHeight),
                  child: Image.asset(AppImages.icnew),
                ),
                GestureDetector(
                  onTap: ()   {
                     controller.rankValue.value = 0;
                     controller.selectedFilter.value = "Tất cả";
                     controller.selectedRankTemp.value = "Ngày cập nhật";
                     controller.update();
                     controller.applyFilters();
                     print( controller.selectedFilter.value);
                     print(controller.selectedRankFilter.value);
                     Get.to(FilterComicView());                
                  },
                  child: TextCustom(
                    text: "Truyện mới cập nhật",
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontsize: sizefix(15, screenWidth),
                  ),
                ),
            
              ],
            ),
   
          ],
        ),
        SizedBox(height: sizefix(15, screenHeight)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListComicNew(),
        ),
      ],
    );
  }
}

class ListComicNew extends GetView<DashboardController> {
  const ListComicNew({super.key});
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    return Obx(() {
      var listComicNew = controller.listcomicNewUpdate.value;
      // Giới hạn số lượng item
      int itemCount = listComicNew.length > 5 ? 5 : listComicNew.length;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < itemCount; i++)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ComicItems(
                comic: listComicNew[i],
                cateList: 0,
              ),
            ),
        ],
      );
    });
  }
}