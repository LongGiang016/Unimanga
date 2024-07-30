import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/book_case/controllers/book_case_controller.dart';

import '../../../../constants/app_function.dart';
import '../../../../global_widgets/comic_items.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ComicReadedView extends GetView<BookCaseController> {
  const ComicReadedView({super.key});

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return firebaseUser == null
        ? Container(
            padding: EdgeInsets.only(top: sizefix(200, screenHeight)),
            color: AppColors.lightWhite,
            child: Column(
              children: [
                Center(
                    child: TextCustom(
                        text: "Bạn cần đăng nhập để xem truyện đã theo dõi")),
                Container(
                  margin: EdgeInsets.only(top: sizefix(40, screenHeight)),
                  width: sizefix(200, screenWidth),
                  height: sizefix(40, screenHeight),
                  decoration: BoxDecoration(
                      color: AppColors.RedPrimary,
                      borderRadius: BorderRadius.circular(
                          sizefix(20, screenHeight))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustom(
                        text: "Đăng Nhập",
                        color: AppColors.lightWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ))
        : Container(
            color: AppColors.lightWhite,
            child: RefreshIndicator(
              onRefresh: () => controller.fetchComicReaded(firebaseUser.uid),
              child: Container(
                padding: EdgeInsets.only(top: sizefix(10, screenHeight)),
                width: screenWidth,
                color: AppColors.lightWhite,
                child: Obx(() {
                  if (controller.listComicRead.isEmpty) {
                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        height: sizefix(400, screenHeight),
                        child: Center(
                          child: TextCustom(
                            text: "Không có truyện đã đọc !",
                            color: AppColors.RedPrimary,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 0.58,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(controller.listComicRead.length, (index) {
                        return ComicItems(
                          comic: controller.listComicRead[index], cateList: 1,
                        );
                      }),
                    );
                  }
                }),
              ),
            ),
          );
  }
}