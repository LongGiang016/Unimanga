import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/global_widgets/category_item.dart';
import 'package:unimanga_app/app/global_widgets/comic_items.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/category/bindings/category_binding.dart';
import 'package:unimanga_app/app/modules/category/controllers/category_controllers.dart';
import 'package:unimanga_app/app/modules/filter_comic/controllers/fillter_comic_controllers.dart';
import 'package:unimanga_app/app/modules/filter_comic/views/child_widget/chid_widget.dart';
import '../../../constants/app_function.dart';


double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}


class FilterComicView extends GetView<FilterController> {
  const FilterComicView({super.key});

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    CategoryBinding().dependencies();
    final categoryController = Get.find<CategoryController>(); 
    return Scaffold(
      body: Container(
        color: AppColors.lightWhite,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: sizefix(20, screenHeight)),              
              padding: EdgeInsets.only(top: sizefix(10, screenHeight)),              
              height: sizefix(80, screenHeight),
              width: screenWidth,
              decoration:  BoxDecoration(
                color: AppColors.RedPrimary,
              ),
              child:Row(
                children: [
                  IconButton(
                    onPressed: () {
                       controller.selectedRankTemp.value = "Ngày cập nhật";
                       controller.selectedStatusTemp.value = "Tất cả";
                       controller.rankValue.value = 0;
                       controller.statusValue.value = 0;
                       controller.applyFilters();
                       controller.isFetching.value = false;
                       Get.back();
                    }, 
                    icon:  Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.lightWhite,)
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                    child: TextCustom(text: "Danh Sách Truyện", fontsize: sizefix(16, screenHeight), color: AppColors.lightWhite,),
                  )
                ],
              ),
            ),
            Container(
              color: AppColors.lightWhite,
              padding: EdgeInsets.symmetric(
                horizontal: sizefix(10, screenWidth),
              ),
              height: sizefix(40, screenHeight),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          Row(
                            children: [
                              TextCustom(text: "Xếp theo:    ", fontWeight: FontWeight.bold,),
                              //TextCustom(text: controller.GetSRankValue(),),
                              Obx(() => TextCustom(text:  controller.selectedRankTemp .value), ),
                            ],
                          ),
                          Row(
                            children: [
                              TextCustom(text: "Trạng thái:  ",fontWeight: FontWeight.bold,),
                               Obx(() =>  TextCustom(text: controller.selectedStatusTemp.value),),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  color: AppColors.lightWhite,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sizefix(10, screenHeight),
                                    vertical: sizefix(20, screenHeight),
                                  ),
                                  height: sizefix(500, screenHeight),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: sizefix(10, screenHeight)),
                                        child: TextCustom(text: "Trạng thái: ", fontsize: sizefix(13, screenWidth)),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() {
                                            return SortToStatus(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              text: "Tất cả",
                                              statusValue: 0,
                                              isSelected: controller.selectedFilter.value == 'Tất cả',
                                            );
                                          }),
                                           Obx(() {
                                            return SortToStatus(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              text: "Hoàn thành",
                                              statusValue: 1,
                                              isSelected: controller.selectedFilter.value == 'Hoàn thành',
                                            );
                                          }),
                                           Obx(() {
                                            return SortToStatus(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              text: "Đang cập nhật",
                                              statusValue: 2,
                                              isSelected: controller.selectedFilter.value == 'Đang cập nhật',
                                            );
                                          }),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: sizefix(10, screenHeight), top: sizefix(10, screenHeight)),
                                        child: TextCustom(text: "Xếp theo: ", fontsize: sizefix(13, screenWidth)),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(() {
                                            return SortToHot(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              rankValue: 0,
                                              text: "Ngày cập nhật",
                                              isSelected: controller.selectedRankFilter.value == 'Ngày cập nhật',
                                            );
                                          }),
                                         Obx(() {
                                            return SortToHot(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              rankValue: 1,
                                              text: "Lượt xem",
                                              isSelected: controller.selectedRankFilter.value == 'Lượt xem',
                                            );
                                          }),
                                          Obx(() {
                                            return SortToHot(
                                              screenHeight: screenHeight,
                                              screenWidth: screenWidth,
                                              rankValue: 2,
                                              text: "Lượt thích",
                                              isSelected: controller.selectedRankFilter.value == 'Lượt thích',
                                            );
                                          }),
                                        ],
                                      ),
                                       Padding(
                                        padding: EdgeInsets.only(bottom: sizefix(10, screenHeight), top: sizefix(10, screenHeight)),
                                        child: TextCustom(text: "Thể loại: ", fontsize: sizefix(13, screenWidth)),
                                      ),
                                      Container(
                                        child: SingleChildScrollView(
                                          child: GridView.count(
                                            crossAxisCount: 2,
                                            childAspectRatio: 3,
                                            shrinkWrap: true,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            physics: const NeverScrollableScrollPhysics(),  
                                            children: List.generate(
                                              // ignore: invalid_use_of_protected_member
                                              categoryController.listCatorogy.value.length,
                                              (index) {
                                                return CategoryComicItem(
                                                  screenHeight: screenHeight,
                                                  screenWidth: screenWidth,
                                                  // ignore: invalid_use_of_protected_member
                                                  cate: categoryController.listCatorogy.value[index],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.applyFilters();                       
                                            controller.isFetching.value = true;
                                            controller.setStatusValue(controller.statusValue.value);
                                            controller.setRankValue(controller.rankValue.value);
                                            controller.UpadetStatus(controller.selectedFilter.value);
                                            controller.UpadetRankfilter(controller.selectedRankFilter.value);
                                            Get.back();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(sizefix(10, screenWidth)),
                                              color: AppColors.RedPrimary,
                                            ),
                                            alignment: Alignment.center,
                                            height: sizefix(30, screenHeight),
                                            width: screenWidth,
                                            child: TextCustom(text: "Tìm Kiếm", color: AppColors.lightWhite,),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: sizefix(20, screenHeight)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          height: sizefix(35, screenHeight),
                          width: sizefix(85, screenWidth),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
                            color: AppColors.RedPrimary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_alt_outlined, size: sizefix(20, screenHeight), color: AppColors.lightWhite),
                              TextCustom(text: "Lọc mới", fontsize: sizefix(12, screenHeight), color: AppColors.lightWhite),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height:500 ,
              color: AppColors.lightWhite,
              child: Obx(() {
                if (controller.listComicFiltered.isEmpty && controller.isFetching.value == true) {
                  return Center(
                    child: TextCustom(text: "Không có truyện cần tìm!")
                  );
                }
                return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.58,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    controller.isFetching.value
                        ? controller.listComicFiltered.length
                        : controller.listComicAll.length,
                    (index) {
                      return ComicItems(
                        comic: controller.isFetching.value
                            ? controller.listComicFiltered[index]
                            : controller.listComicAll[index],cateList: 0
                      );
                    },
                  ),
                );
              }),
            ),

          ],
        ),
      ),
    );
  }
}


