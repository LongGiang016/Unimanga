import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:unimanga_app/app/constants/app_function.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/comment/provider/comment_provider.dart';
import '../../../global_widgets/comment_items.dart';
import '../../../models/chap_comic.dart';
import '../../../models/comic_model.dart';
import '../../chapter/controllers/chapter_controllers.dart';
import '../../dashboard/controllers/dashboard_controllers.dart';
import '../../infor_user/controller/user_controller.dart';
import '../controllers/comment_controllers.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class CommentChapComicView extends GetView<CommentController> {
  CommentChapComicView({super.key, required this.chapComicModel, this.comic});

  final ChapComicModel chapComicModel;
  final TextEditingController commentController = TextEditingController();
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  ComicModel? comic;

  @override
  Widget build(BuildContext context) {
    List<CommentChapComic> listComment = chapComicModel.comment!;
    final userinforController = Get.find<InforUserController>();
    final dashController = Get.find<DashboardController>();
    final commentpro = Get.find<CommentProvider>();
    final chapterController = Get.find<ChapterController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => controller.fetchCommentChap(dashController.comic.value.id!, dashController.chapComic.value.id!),
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.lightWhite,
                margin: EdgeInsets.only(top: sizefix(70, screenHeight), bottom: sizefix(75, screenHeight)),
                constraints: BoxConstraints(minHeight: screenHeight), // Thêm dòng này để đặt chiều cao tối thiểu
                child: Obx(() {
                  return Column(
                    children: [
                      controller.listCommentChap.isEmpty
                        ?Container(
                            height: screenHeight,
                            child: Center(child: TextCustom(text: "Chưa có bình luận nào cả!")),
                          )
                        :ListComment(screenHeight: screenHeight, screenWidth: screenWidth),
                    ],
                  );
                }),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
              width: screenWidth,
              height: sizefix(60, screenHeight),
              decoration: BoxDecoration(
                color: AppColors.lightWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, size: sizefix(16, screenHeight)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sizefix(20, screenWidth)),
                    child: TextCustom(
                      text: "Bình luận",
                      fontsize: sizefix(17, screenWidth),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
              width: screenWidth,
              height: sizefix(80, screenHeight),
              decoration: BoxDecoration(
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.tag_faces_outlined)),
                  IconButton(
                      onPressed: () async {
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
                          controller.addComment(
                              commentController.text,
                              userinforController.user.value!.name!,
                              firebaseUser!.uid,
                              userinforController.user.value!.imageUrl!,
                              userinforController.user.value!.score!.toString(),
                              dashController.chapComic.value.id!);
                          int sobl = controller.listCommentChap.value.length;
                          await commentpro.addCommmentToBrosew(
                              firebaseUser!.uid,
                              dashController.comic.value.ten!,
                              dashController.comic.value.id!,
                              dashController.chapComic.value.id!,
                              dashController.chapComic.value.tenChuong!,
                              sobl.toString(),
                              commentController.text);
                          controller.fetchCommentChap(dashController.comic.value.id!, dashController.chapComic.value.id!);
                          controller.update();
                          commentController.clear();
                          Get.snackbar(
                            "Thông báo",
                            "Bạn đã bình luận thành công ^^",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        }
                      },
                      icon: const Icon(Icons.send_rounded))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListComment extends GetView<CommentController> {
  const ListComment({super.key, required this.screenHeight, required this.screenWidth});
  final screenHeight;
  final screenWidth;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < controller.listCommentChap.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: ItemComment(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                commentChapComic: controller.listCommentChap[i],
              ),
            )
        ],
      );
    });
  }
}
