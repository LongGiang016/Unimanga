import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/modules/comment/controllers/comment_controllers.dart';
import '../../../global_widgets/comment_items.dart';
import '../../../global_widgets/tag_custom.dart';
import '../../../global_widgets/text_custom.dart';
import '../../dashboard/controllers/dashboard_controllers.dart';
import '../../infor_user/controller/user_controller.dart';

 double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

class ComicDetailView extends GetView<CommentController> {
  const ComicDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final userinforController = Get.find<InforUserController>();
     final dashController = Get.find<DashboardController>();
    final dcontroller = Get.find<DashboardController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: AppColors.lightWhite,
        child: RefreshIndicator(
          onRefresh: () => controller.fecchComentById(
            dcontroller.comic.value.id!,
            dcontroller.chapComic.value.id!,
            controller.comment.value.id!,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: sizefix(75, screenHeight), bottom:sizefix(75, screenHeight) ),
                    child: Column(
                      children: [
                        Obx(() {
                          return Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: AppColors.lightWhite,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: sizefix(10, screenWidth),
                                    vertical: sizefix(10, screenHeight),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              controller.comment.value.hinhNen!,
                                              height: sizefix(37, screenHeight),
                                              width: sizefix(37, screenWidth),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: sizefix(10, screenWidth)),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextCustom(
                                                text: controller.comment.value.tenNguoiDung,
                                                fontWeight: FontWeight.bold,
                                                fontsize: sizefix(13, screenWidth),
                                              ),
                                              TagWidgetItems(score: int.parse(controller.comment.value.soXu.toString())),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: sizefix(5, screenHeight)),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: sizefix(5, screenWidth)),
                                        child: TextCustom(
                                          text: controller.comment.value.content ?? '',
                                          fontsize: sizefix(12, screenWidth),
                                        ),
                                      ),
                                      SizedBox(height: sizefix(5, screenHeight)),
                                      Container(
                                        padding: EdgeInsets.only(left: sizefix(5, screenWidth)),
                                        child: Row(
                                          children: [
                                            TextCustom(
                                              text: controller.comment.value.ngay ?? '',
                                              fontsize: sizefix(11, screenWidth),
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: sizefix(10, screenWidth)),
                                            TextCustom(
                                              text: controller.comment.value.thoiGian ?? '',
                                              fontsize: sizefix(11, screenWidth),
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: AppColors.gray,
                                  height: 10,
                                ),
                                SizedBox(height: sizefix(20, screenHeight)),
                                 Obx(() {
                                  return controller.comment.value.phanHoi!.isEmpty
                                      ? Center(
                                          child: TextCustom(
                                            text: "Không có bình luận phản hồi nào cả!",
                                          ),
                                        )
                                      : ListComicAction(screenHeight: screenHeight, screenWidth: screenWidth);
                                  })
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  height: sizefix(70, screenHeight),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.blackPrimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                        child: TextCustom(
                          text: "Chi Tiết Bình Luận",
                          fontsize: sizefix(16, screenHeight),
                          color: AppColors.blackPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizefix(10, screenWidth),
                  ),
                  width: screenWidth,
                  height: sizefix(80, screenHeight),
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    border: Border.all(
                      color: AppColors.grayBlack,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          cursorColor: AppColors.gray,
                          maxLines: null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.gray,
                            hintText: "Viết bình luận...",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.tag_faces_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          if (userinforController.user.value == null) {
                            Get.snackbar(
                              "Thông báo",
                              "Vui lòng đăng nhập để sử dụng chức năng",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else if (commentController.text.isEmpty) {
                            Get.snackbar(
                              "Thông báo",
                              "Vui lòng nhập nội dụng để bình luận",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            controller.addCommentRepon(
                              commentController.text,
                              userinforController.user.value!.name!,
                              firebaseUser!.uid,
                              userinforController.user.value!.imageUrl!,
                              userinforController.user.value!.score!.toString(),
                            );
                            controller.fecchComentById(dashController.comic.value.id!, dashController.chapComic.value.id!, controller.comment.value.id!);
                            Get.snackbar(
                              "Thông báo",
                              "Bạn đã phản hồi bình luận thành công ^^",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                            );
                          }
                        },
                        icon: Icon(Icons.send_rounded, color: AppColors.RedPrimary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListComicAction extends GetView<CommentController> {
  const ListComicAction({super.key, required this.screenHeight, required this.screenWidth});
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < controller.comment.value.phanHoi!.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ItemComment(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                commentChapComic: controller.comment.value.phanHoi![i],
              ),
            ),
        ],
      );
    });
  }
}
