import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/comic_detail/views/detail_child/personal_review.dart';
import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../global_widgets/comment_items.dart';
import '../../../../global_widgets/text_custom.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class RateComicView extends GetView<DashboardController> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final userController = Get.find<InforUserController>();
    print("${controller.comic.value.rateComic!.length}");
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fecchComic (controller.comic.value.id!);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: sizefix(20, screenHeight)),
              height: sizefix(150, screenHeight),
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.lightWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // Điều chỉnh vị trí đổ bóng
                  ),
                ],
                border: Border(
                  bottom: BorderSide(
                    width: 0.2,
                    color: Colors.grey.withOpacity(0.5), // Màu viền dưới
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.black,
                        ),
                      ),
                     Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                        child: TextCustom(
                          text: controller.comic.value.ten,
                          fontsize: sizefix(16, screenHeight),
                          color: AppColors.black,
                        ),
                      );
                    })
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sizefix(17, screenHeight), top: sizefix(20, screenHeight), right: sizefix(17, screenHeight)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       Obx(() {
                          return Row(
                            children: [
                              TextCustom(
                                text: "${controller.calculateAverageRating(controller.comic.value.rateComic!)}",
                                fontsize: sizefix(25, screenHeight),
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              StarRating(
                                rating: double.parse(controller.calculateAverageRating(controller.comic.value.rateComic!).toString()), 
                                size: sizefix(25, screenWidth),
                                color: Colors.yellow,
                              ),
                            ],
                          );
                        }),
                        GestureDetector(
                          onTap: () => Get.to(PersonalReViewView()),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: sizefix(50, screenWidth)),
                            height: sizefix(25, screenHeight),
                            width: sizefix(80, screenWidth),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
                              color: AppColors.RedPrimary,
                            ),
                            child: TextCustom(
                              text: "Đánh giá",
                              fontsize: sizefix(11, screenHeight),
                              color: AppColors.lightWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              return controller.listsRate.isEmpty
                  ? Expanded(
                      child: Center(
                        child: TextCustom(text: "Chưa có Đánh giá nào cả"),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: sizefix(1, screenHeight)),
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2.7,
                          ),
                          itemCount: controller.listsRate.length,
                          itemBuilder: (context, index) {
                            return ItemRate(
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              commentChapComic: controller.listsRate[index],
                            );
                          },
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  StarRating({
    required this.rating,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(Icon(
          Icons.star_rate_rounded,
          color: color,
          size: size,
        ));
      } else if (i - rating <= 1) {
        stars.add(Stack(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.grey,
              size: size,
            ),
            ClipRect(
              clipper: _StarClipper((rating - (i - 1)) * size),
              child: Icon(
                Icons.star_rate_rounded,
                color: color,
                size: size,
              ),
            ),
          ],
        ));
      } else {
        stars.add(Icon(
          Icons.star_rate_rounded,
          color: Colors.grey,
          size: size,
        ));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double width;

  _StarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}