import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import 'package:unimanga_app/app/modules/dashboard/provider/dashboard_provider.dart';

import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';

import '../../../../constants/app_function.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class PersonalReViewView extends GetView<DashboardController> {
  PersonalReViewView({super.key});
  final TextEditingController commentController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final userController = Get.find<InforUserController>();
    final controllerpro = Get.find<DashboardProvider>();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: sizefix(15, screenWidth)),
        color: AppColors.lightWhite,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: sizefix(30, screenWidth)),
              height: sizefix(60, screenHeight),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back_ios_new, color: AppColors.black,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sizefix(20, screenHeight)),
                    child: TextCustom(text: "Đánh giá", fontsize: sizefix(21, screenHeight),),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: sizefix(30, screenHeight)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Row(
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () {
                            // Cập nhật rating khi người dùng chạm vào sao
                            controller.updateRating(index + 1);
                          },
                          icon: Icon(
                            Icons.star_rate_rounded,
                            color: index < controller.rating.value
                                ? AppColors.yellowPrimary
                                : Colors.grey,
                            size: sizefix(45, screenWidth),
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
            TextCustom(text: "Đánh giá của bạn có thể giúp thêm nhiều độc giả chọn được truyện hay này đấy", textalign: TextAlign.center,),
            Container(
              margin: EdgeInsets.only(top: sizefix(20, screenHeight)),
              padding: EdgeInsets.all(sizefix(10, screenWidth)),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(sizefix(10, screenWidth)),
              ),
              child: TextField(
                controller: commentController,
                maxLines: 13,
                decoration: const InputDecoration(
                  hintText: "Bạn nghĩ gì về tác phẩm này, Hãy chia sẻ cảm nhận của bạn sau khi đọc",
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: ()  async{
                if (commentController.text.isEmpty || controller.rating.value == 0) {
                  Get.snackbar(
                    "Thông báo",
                    "Vui lòng nhập đầy đủ thông tin hoặc đánh giá truyện",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                }else if(userController.user.value == null){
                   Get.snackbar(
                    "Thông báo",
                    "Vui lòng đăng nhập để đọc truyện",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                
                }
                 else {
                  controller.addRating(commentController.text, userController.user.value!.name!, firebaseUser!.uid, userController.user.value!.imageUrl!);
                  controller.fecchComic(controller.comic.value.id!);
                  controller.fetchComicRate(controller.comic.value.id!);
                  //await controllerpro.addRatingToBrosew(firebaseUser!.uid, controller.comic.value.ten!,controller.comic.value.id!, controller.chapComic!.value.id!, controller.chapComic.value.tenChuong!, controller.comic.value.rateComic.);
                  // Thêm thông báo khi thêm đánh giá thành công
                  Get.snackbar(
                    "Thông báo",
                    "Bạn đã dánh giá thành công, ^^",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                  // Xóa nội dung trong TextField và đặt lại rating về 0 sau khi thêm thành công
                  commentController.clear();
                  controller.rating.value = 0;
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: sizefix(20, screenWidth)),
                height: sizefix(25, screenHeight),
                width: sizefix(70, screenWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
                  color: AppColors.RedPrimary,
                ),
                child: TextCustom(
                  text: "Gửi",
                  fontsize: sizefix(12, screenHeight),
                  color: AppColors.lightWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
