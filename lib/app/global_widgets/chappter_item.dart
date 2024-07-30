import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/models/chap_comic.dart';
import 'package:unimanga_app/app/modules/chapter/bindings/chapter_binding.dart';
import 'package:unimanga_app/app/modules/chapter/views/chapter_view.dart';

import '../constants/index.dart';
import '../models/comic_model.dart';
import '../modules/chapter/controllers/chapter_controllers.dart';
import '../modules/dashboard/controllers/dashboard_controllers.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ChappterItem extends GetView {
  ChappterItem({super.key, required this.screenHeight, required this.screenWidth, required this.chappter, this.comic});
  final screenWidth ;
  final screenHeight;
  final ChapComicModel chappter;
  ComicModel? comic;
  @override
  Widget build (BuildContext context){
    return  GestureDetector(
      onTap: () async{
       ChapterBinding().dependencies();
       final dashboardController = Get.find<DashboardController>();
       final chapterController = Get.find<ChapterController>();
       await dashboardController.fetchImageChap(comic!.id!, chappter.id!);
       await dashboardController.fecchComicChapById(comic!.id!, chappter.id!);
       int newlike = int.parse(dashboardController.comic.value.luotXem.toString()) + 1;
        dashboardController.updateView(dashboardController.comic.value.id!,newlike.toString());
       chapterController.isUpdated.value = false;
       Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500), 
            pageBuilder: (context, animation, secondaryAnimation) =>
             ChapterView(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              chapComicModel: chappter,
              comic: comic,
            ),
            
          ),
        );
      },
      child: Container(
       width: screenWidth,
       height: sizefix(60, screenHeight),
       decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey),
          bottom: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey)
        )
       ),
       child: Padding(
         padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
         child: Row(
           children: [
             Container(
                padding: EdgeInsets.only(right: sizefix(10, screenWidth)),
                width: sizefix(40, screenWidth),
                height: sizefix(40, screenHeight),
                child: Image.asset(
                  chappter.loaiChuong == "0" ? AppImages.icChapFree : AppImages.icChapVip,
                ),
              ),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(text: chappter.tenChuong ,fontsize: sizefix(14, screenHeight),),
                Padding(
                  padding: EdgeInsets.only(top: sizefix(5, screenHeight)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: sizefix(5, screenWidth)),
                        child: TextCustom(text:chappter.thoiGianCapNhat, fontsize: sizefix(10, screenWidth), color: Colors.grey,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: sizefix(5, screenWidth)),
                        //child: TextCustom(text: chappter.loaiChuong,fontsize: sizefix(10, screenWidth), color: Colors.grey,),
                      ),
                      Row(
                        children: [
                          Icon(Icons.comment_rounded, color: Colors.grey, size: sizefix(10, screenWidth),),
                          TextCustom(text: " ${chappter.comment?.length}" ,fontsize: sizefix(10, screenWidth), color: Colors.grey,)
                        ],
                      )
                      
                    ],
                  ),
                )
              ],
             ),
           ],
         ),
       ),
      ),
    );
  }
}