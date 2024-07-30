import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_function.dart';
import '../../../../global_widgets/image_chapter.dart';
import '../../../../global_widgets/text_custom.dart';
import '../../../../models/chap_comic.dart';
import '../../../../models/comic_model.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../../../infor_user/controller/user_controller.dart';
import '../../../infor_user/provider/info_user_provider.dart';
import '../../provider/chapter_provider.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChapterDefault extends GetView<ChapterController> {
  ChapterDefault({
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
    final dashboardController = Get.find<DashboardController>();
    final inforUserController = Get.find<InforUserController>();
    final user = inforUserController.user.value;
    int userScore = user?.score ?? 0;
    int newScore = userScore - 2; 
    List<ImageChap> listImageChap = chapComicModel.imageChap!;
    bool hasData = listImageChap.isNotEmpty;
    final infor = Get.find<InforUserProvider>();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final chapterProvider = ChapterProvider();
     if (dashboardController.chapComic.value.loaiChuong == "1") {
      // Kiểm tra nếu chưa đọc chương này
      chapterProvider.isChapterUnlocked(firebaseUser!.uid!, comic!.id!, chapComicModel.id!).then((isUnlocked) {
        if (!isUnlocked) {
          // Thực hiện trừ điểm và thêm vào danh sách đã đọc
          infor.updateScoreByUid(firebaseUser.uid!, userScore - 2);
          chapterProvider.addChapComicReaded(firebaseUser.uid!, comic!.ten!, comic!.id!, chapComicModel.id!);
        }
      });
    }
    //chapterProvider.addChapComicReaded(firebaseUser!.uid, comic!.ten!, comic!.id!, chapComicModel.id!);
    return RefreshIndicator(
      onRefresh: ()=> dashboardController.fecchComic(dashboardController.comic.value.id!),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
        ),
        child: hasData
            ? _buildImageGridView(dashboardController)
            : Center(child: TextCustom(text: "Dữ liệu đang update")),
      ),
    );
  }

  Widget _buildImageGridView(DashboardController dashboardController) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 0.67,
      ),
      // ignore: invalid_use_of_protected_member
      itemCount: dashboardController.listchap.value.length,
      itemBuilder: (context, index) {
        return Obx(() {
          return ImageChapItem(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            // ignore: invalid_use_of_protected_member
            imageChap: dashboardController.listchap.value[index],
          );
        });
      },
    );
  }
}

