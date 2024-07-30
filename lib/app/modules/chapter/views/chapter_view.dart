

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/models/chap_comic.dart';
import 'package:unimanga_app/app/models/comic_model.dart';
import 'package:unimanga_app/app/modules/book_case/controllers/book_case_controller.dart';
import 'package:unimanga_app/app/modules/book_case/provider/book_case_provider.dart';
import 'package:unimanga_app/app/modules/chapter/bindings/chapter_binding.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import 'package:unimanga_app/app/modules/chapter/views/chapter_view_child/chapter_bottom.dart';
import 'package:unimanga_app/app/modules/chapter/views/chapter_view_child/chapter_content.dart';
import 'package:unimanga_app/app/modules/chapter/views/chapter_view_child/chapter_defautl.dart';
import 'package:unimanga_app/app/modules/chapter/views/chapter_view_child/chapter_top.dart';
import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';
import '../../comment/bindings/comment_binding.dart';
import '../../dashboard/controllers/dashboard_controllers.dart';
import '../../infor_user/bindings/info_user_bindings.dart';
import '../provider/chapter_provider.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChapterView extends GetView<ChapterController> {
  
  ChapterView({required this.screenHeight, required this.screenWidth, required this.chapComicModel, this.comic, this.currentIndex});

  final double screenWidth;
  final double screenHeight;
  final ChapComicModel chapComicModel;
  ComicModel? comic;
  var currentIndex;

  @override
  Widget build(BuildContext context) {
    CommentBindings().dependencies();
    ChapterBinding().dependencies();
    InforUserbinding().dependencies();
    final bookCasepro = Get.find<BookCaseProvider>();
    final bookCaseControl = Get.find<BookCaseController>();
    final dashboardController = Get.find<DashboardController>();
    final inforUser = Get.find<InforUserController>();
    final chapterProvider = ChapterProvider();
  
    int loaiChuong = int.tryParse(chapComicModel.loaiChuong.toString()) ?? 0;
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    controller.idChap.value = int.tryParse(chapComicModel.id.toString()) ?? 0;

    Future<void> _refresh() async {
      await inforUser.fetchUser(firebaseUser!.uid);
    }

    if (firebaseUser == null) {
      return GestureDetector(
        onDoubleTap: () => controller.toggleContainerVisibility(),
        child: Scaffold(
          backgroundColor: AppColors.lightWhite,
          body: Stack(
            children: [
              // Phần nội dung chiếm toàn bộ màn hình                  
              ChappterCoin(screenHeight: screenHeight, screenWidth: screenWidth, chapComicModel: chapComicModel, comic: comic),                  
              // Phần top chồng lên phần nội dung
              Positioned(
                top: 0,
                child: Obx(() => AnimatedOpacity(
                  opacity: controller.isContainerVisible.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: ChappterTop(screenHeight: screenHeight, screenWidth: screenWidth, chapComicModel: chapComicModel, comic: comic),
                )),
              ),                    
              // Phần bottom chồng lên phần nội dung
              Positioned(
                bottom: 0,
                child: Obx(() => AnimatedOpacity(
                  opacity: controller.isContainerVisible.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: ChappterBottom(screenHeight: screenHeight, screenWidth: screenWidth, chapComicModel: chapComicModel, comic: comic),
                )),
              ),
            ],
          ),
          ),
      );
    }

    return FutureBuilder<bool> (
      future: chapterProvider.isChapterUnlocked(firebaseUser.uid, comic!.id!, chapComicModel.id!),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bookCasepro.addComicIntoComicReaded(firebaseUser.uid, comic!.ten!,  comic!.id!, comic!.anhTruyen!, bookCasepro.TruyenDaDoc, chapComicModel.id!, chapComicModel.tenChuong!);
        bookCaseControl.chapId.value = int.parse(chapComicModel.id.toString());
        bookCaseControl.fetchComicDetail(firebaseUser.uid, dashboardController.comic.value.id!);
        bookCaseControl.chapName.value = chapComicModel.tenChuong!;
        bookCaseControl.comicId.value = int.parse(comic!.id!.toString());
        inforUser.fetchUser(firebaseUser.uid);
        dashboardController.chapCmicTest.value = chapComicModel;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          bool isUnlocked = snapshot.data ?? false;
          return GestureDetector(
            onDoubleTap: () => controller.toggleContainerVisibility(),
            child: Scaffold(
              backgroundColor: AppColors.lightWhite,
              body: RefreshIndicator(
                onRefresh: _refresh,
                child: SingleChildScrollView(
                   physics: AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: [                
                   Obx(() {
  final user = inforUser.user.value;

  if (loaiChuong == 1 && !isUnlocked && user!.statuscomic == 0) {
    return ChappterCoin(
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      chapComicModel: chapComicModel,
      comic: comic,
    );
  } else if (user!.score! <= 0 && !isUnlocked && loaiChuong == 1 ) {
    return ChappterCoin(
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      chapComicModel: chapComicModel,
      comic: comic,
    );
  } else {
    return ChapterDefault(
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      chapComicModel: chapComicModel,
      comic: comic,
    );
  }
}),

                      // Phần top chồng lên phần nội dung
                      Positioned(
                        top: 0,
                        child: Obx(() => AnimatedOpacity(
                          opacity: controller.isContainerVisible.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: ChappterTop(screenHeight: screenHeight, screenWidth: screenWidth, chapComicModel: chapComicModel, comic: comic),
                        )),
                      ),
                      
                      // Phần bottom chồng lên phần nội dung
                      Positioned(
                        bottom: 0,
                        child: Obx(() => AnimatedOpacity(
                          opacity: controller.isContainerVisible.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: ChappterBottom(screenHeight: screenHeight, screenWidth: screenWidth, chapComicModel: chapComicModel, comic: comic),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

