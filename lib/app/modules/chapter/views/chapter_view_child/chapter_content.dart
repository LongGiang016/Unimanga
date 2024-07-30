import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import 'package:unimanga_app/app/modules/payment/mainpayment.dart';
import 'package:unimanga_app/app/modules/signin/views/SignIn.dart';
import '../../../../constants/index.dart';
import '../../../../global_widgets/image_chapter.dart';
import '../../../../global_widgets/index.dart';
import '../../../../models/chap_comic.dart';
import '../../../../models/comic_model.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../../../infor_user/controller/user_controller.dart';
import '../../../infor_user/provider/info_user_provider.dart';
import '../../../payment/bindings/payment_binding.dart';
import '../../provider/chapter_provider.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChappterCoin extends GetView<ChapterController> {
  ChappterCoin({
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

    final inforUserController = Get.find<InforUserController>();
    final user = inforUserController.user.value;
    final dashboardController = Get.find<DashboardController>();
    final infor = Get.find<InforUserProvider>(); 
    List<ImageChap> listImageChap = chapComicModel.imageChap!;
    bool hasData = listImageChap.isNotEmpty;
    int userScore = user?.score ?? 0;
    int newScore = userScore - 2; 
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    return Container(
      padding: EdgeInsets.only(
        top: sizefix(70, screenHeight), 
        left: sizefix(12, screenWidth), 
        right: sizefix(12, screenWidth)
      ),
      height: screenHeight,
      width: screenWidth,
      child: Obx(() {
        if (controller.isUpdated.value) {
          return _buildUpdatedContent(dashboardController, hasData);
        } else {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: sizefix(30, screenHeight)),
                child: TextCustom(
                  text: "Thông Báo", 
                  fontsize: sizefix(16, screenWidth), 
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextCustom(text: "Nội dung hình ảnh của chương này bị khóa, bạn vui lòng MỞ KHÓA chương để đọc."),
              Padding(
                padding: EdgeInsets.only(bottom: sizefix(30, screenHeight), top: sizefix(30, screenHeight)),
                child: TextCustom(text: "Để mở khóa, vui lòng click vào nút mở khóa ở dưới để xem full hình ảnh"),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: sizefix(30, screenHeight)),
                child: TextCustom(
                  text: "Nếu bạn không đủ xu, vui lòng click vào nút NẠP XU.", 
                  color: AppColors.RedPrimary, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (user == null) {
                    _showLoginDialog(context);
                  } else if (userScore < 2) {
                    _showNotEnoughScoreDialog(context);
                  } else {
                    final chapterProvider = ChapterProvider();
                    infor.updateScoreByUid(firebaseUser!.uid, newScore);
                   chapterProvider.addChapComicReaded(firebaseUser!.uid, comic!.ten!, comic!.id!, chapComicModel.id!).then((_) {                     
                      controller.isUpdated.value = true;
                    });
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: sizefix(60, screenHeight)),
                  width: screenWidth,
                  height: sizefix(40, screenHeight),
                  decoration: BoxDecoration(
                    color: AppColors.RedPrimary,
                    borderRadius: BorderRadius.circular(sizefix(20, screenHeight))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: AppColors.lightWhite,),
                      TextCustom(
                        text: " Mở Khóa (2 Xu)", 
                        color: AppColors.lightWhite, 
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                
                onTap: () {
                 if (user == null) {
                    _showLoginDialog(context);
                  }else{
                   Get.to(PaymentView(), binding:  PaymentBinding());
                  }
                
                },
                child: Container(
                  width: screenWidth,
                  height: sizefix(40, screenHeight),
                  decoration: BoxDecoration(
                    color: AppColors.RedPrimary,
                    borderRadius: BorderRadius.circular(sizefix(20, screenHeight))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_money, color: AppColors.lightWhite,),
                      TextCustom(
                        text: "Nạp Xu", 
                        color: AppColors.lightWhite, 
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }


  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  TextCustom(text: "Thông Báo", fontsize: 14, fontWeight: FontWeight.bold,),
          content: SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                TextCustom(text: "Vui lòng đăng nhập",fontsize: sizefix(12, screenHeight),),
                GestureDetector(
                  onTap: () => Get.to( Login_Screen()),
                  child: Container(
                    margin: EdgeInsets.only(top: sizefix(10, screenWidth)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.RedPrimary
                    ),
                    height: sizefix(25, screenHeight),
                    width: sizefix(100, screenWidth),
                    child: TextCustom(text: "Đăng nhập",fontsize: 12, color: AppColors.lightWhite,),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUpdatedContent(DashboardController dashboardController, bool hasData) {
    
    return RefreshIndicator(
      onRefresh: () => dashboardController.fecchComic(dashboardController.comic.value.id!),
      child: Container(
        alignment: Alignment.bottomCenter,
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(color: AppColors.lightWhite),
        child: hasData
            ? GridView.builder(
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
              )
            : Center(child: TextCustom(text: "Dữ liệu đang update")),
      
      ),
    );
  }
}

void _showNotEnoughScoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: TextCustom(text: "Không đủ điểm"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextCustom(text: "Số điểm của bạn không đủ để mở khóa chương, vui lòng nạp thêm."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(PaymentView(), binding:  PaymentBinding());
                },
                child: TextCustom(text: "Nạp thêm điểm"),
              ),
            ],
          ),
        );
      },
    );
  }

