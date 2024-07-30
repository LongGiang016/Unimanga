import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/infor_user/bindings/info_user_bindings.dart';
import '../../../constants/app_function.dart';
import '../../../models/chap_comic.dart';
import '../../../models/comic_model.dart';
import '../../infor_user/controller/user_controller.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChaptetVipBlockView extends GetView {
  ChaptetVipBlockView({super.key, this.chappter, this.comic, required this.screenHeight, required this.screenWidth});
  final ChapComicModel? chappter;
  final ComicModel? comic;
  final screenWidth;
  final screenHeight;
  @override
  Widget build(BuildContext context) {
    InforUserbinding().dependencies();
    final inforUserController = Get.find<InforUserController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final user = inforUserController.user.value;
    return Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [       
            GestureDetector(
              onTap: () {
                if (user == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Vui lòng đăng nhập"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Vui lòng đăng nhập"),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Add your login logic here
                              },
                              child: Text("Đăng nhập"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: Text("vui long nop vip"),
            ),
          ],
        ),
    );
  }
}