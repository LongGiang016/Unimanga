import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/index.dart';

import '../constants/app_images.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  AppbarCustom({
    Key? key,
    this.isBack = true,
    this.isChat = true,
    this.title,
    this.colorAppbar,
    this.colorTitle,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  final bool isBack;
  final bool isChat;
  final String? title;
  final Color? colorAppbar;
  final Color? colorTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorAppbar ?? AppColors.yellowPrimary,
      bottomOpacity: 0.0,
      elevation: 0.0,
      foregroundColor: colorTitle ?? Colors.white,
      leading: isBack
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  GetPlatform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                ),
              ),
            )
          : null,
      automaticallyImplyLeading: isBack,
      title: Text(
        title ?? "",
        style: TextStyle(color: colorTitle ?? Colors.white),
      ),
      actions: [
        isChat
            ? InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppImages.icComment,
                          height: 20,
                          width: 27,
                          fit: BoxFit.fill,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 9,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 7,
                          child: Text(
                            "5",
                            style: TextStyle(fontSize: 8),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
Widget IntroWidgetWithoutLogo() {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.bgProfile), fit: BoxFit.cover)),
    height: Get.height * 0.3,
  );
}

Widget RankingWidget() {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.bgRanking), fit: BoxFit.cover)),
    height: Get.height * 0.3,
  );
}

Widget TagWidget() {
  return Stack(children: [
    // scorce < 100
    Container(
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bgTagLK),
          fit: BoxFit.contain,
        ),
      ),
      height: 40,
    ),
    Padding(
      padding: EdgeInsets.only(top: 15, left: 27),
      child: Text(
        "Luyện khí tầng 1",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8.0,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    ),
  ]);
}
