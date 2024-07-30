
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/constants/app_function.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/models/comic_model.dart';
import 'package:unimanga_app/app/modules/book_case/bindings/book_case_bindings.dart';
import 'package:unimanga_app/app/modules/book_case/controllers/book_case_controller.dart';
import 'package:unimanga_app/app/modules/comic_detail/views/comic_detail.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import '../constants/app_images.dart';


double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ComicItem extends StatefulWidget {
  ComicItem({super.key, this.Catelist});
  var Catelist;
  @override
  State<ComicItem> createState() => _ComicItemState();
}

class _ComicItemState extends State<ComicItem> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(
            right: screenWidth * 0.02, 
            left:screenWidth * 0.02,
            top: screenWidth * 0.01, 
        ),
        width:sizefix(110, screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {},
                child:Container(
                  height: sizefix(120, screenHeight),
                  width: sizefix(110, screenWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizefix(20, screenHeight)),
                    color: AppColors.black,
                    image: const DecorationImage(
                      image: AssetImage(AppImages.HomeBackGround1),
                      fit: BoxFit.cover, 
                      alignment: Alignment.center,
                    ),
                  ),
      
                )
            ),
            TextCustom(
              text: "Konosuba: Phước lành cho thế giới",
              fontWeight: FontWeight.bold,
              fontsize: sizefix(11, screenWidth),
              maxline: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: sizefix(5, screenHeight),
                  bottom:  sizefix(10, screenHeight),
              ),
              child: TextCustom(
                text: "Chương 103",
                fontsize: sizefix(9, screenWidth),
                //fontWeight: FontWeight.bold,
                color: AppColors.grayLight,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class ComicItems extends GetView<DashboardController>{
  ComicItems({super.key, required this.comic, this.cateList});
  final ComicModel comic;
  var cateList;
  @override
  Widget build(BuildContext context) {
    BookCaseBinding().dependencies();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    final bookCaseController = Get.find<BookCaseController>(); 
    return GestureDetector(
      onTap: () async {
        if(firebaseUser == null){
        }
        else{
          await bookCaseController.fetchComicDetail(firebaseUser.uid, comic.id!);
          print("Chương lưu trên bookcase ${bookCaseController.comic.value.ten} và id truyện là ${comic.id}" );
        }
        await controller.fecchComic(comic.id!);
        Get.to(() => ComicDetail(IdChap: comic.chapId, ChapName: comic.chapName,),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500), 
        );
      },
      child: Container(
        padding: EdgeInsets.only(
            right: screenWidth * 0.02, 
            left:screenWidth * 0.02,
            top: screenWidth * 0.01, 
        ),
        width:sizefix(110, screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {},
                child:Container(
                  height: sizefix(120, screenHeight),
                  width: sizefix(110, screenWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
                    color: AppColors.black,
                    image: DecorationImage(
                      image: NetworkImage(comic.anhTruyen!),
                      fit: BoxFit.cover, 
                      alignment: Alignment.center,
                    ),
                  ),
      
                )
            ),
            TextCustom(
              text: comic.ten,
              fontWeight: FontWeight.bold,
              fontsize: sizefix(11, screenWidth),
              maxline: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: sizefix(5, screenHeight),
                  bottom:  sizefix(10, screenHeight),
              ),
              child: TextCustom(
                text: cateList == 0 ?"Chương ${comic.chapComicModel!.length}".toString() : "${comic.chapName}",
                fontsize: sizefix(9, screenWidth),
                //fontWeight: FontWeight.bold,
                color: AppColors.grayLight,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ComicItems1 extends GetView<DashboardController>{
  ComicItems1({super.key, required this.comic, this.Catelist});
  final ComicSecondary comic;
  var Catelist;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;;
    
    return GestureDetector(
      onTap: () async {
        //DashBoardBinding().dependencies();
        await controller.fecchComic(comic.idTruyen!);
        Get.to(() => ComicDetail(IdChap: comic.chapId, ChapName: comic.chapName,),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 500), 
        );
      },
      child: Container(
        padding: EdgeInsets.only(
            right: screenWidth * 0.02, 
            left:screenWidth * 0.02,
            top: screenWidth * 0.01, 
        ),
        width:sizefix(110, screenWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {},
                child:Container(
                  height: sizefix(120, screenHeight),
                  width: sizefix(110, screenWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizefix(10, screenHeight)),
                    color: AppColors.black,
                    image: DecorationImage(
                      image: NetworkImage(comic.imageUrl!),
                      fit: BoxFit.cover, 
                      alignment: Alignment.center,
                    ),
                  ),
      
                )
            ),
            TextCustom(
              text: comic.tenTruyen,
              fontWeight: FontWeight.bold,
              fontsize: sizefix(11, screenWidth),
              maxline: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: sizefix(5, screenHeight),
                  bottom:  sizefix(10, screenHeight),
              ),
              child: TextCustom(
                text: Catelist == 0 ?" " : "${comic.chapName}",
                fontsize: sizefix(9, screenWidth),
                //fontWeight: FontWeight.bold,
                color: AppColors.grayLight,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}