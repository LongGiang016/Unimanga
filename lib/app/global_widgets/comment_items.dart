import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_function.dart';
import 'package:unimanga_app/app/constants/app_images.dart';
import 'package:unimanga_app/app/models/rate_comic.dart';
import 'package:unimanga_app/app/modules/comment/controllers/comment_controllers.dart';
import 'package:unimanga_app/app/modules/comment/views/comment_detail.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import '../constants/app_colors.dart';
import '../models/chap_comic.dart';
import 'tag_custom.dart';
import 'text_custom.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ItemComment extends GetView<CommentController>{
  const ItemComment({super.key, required this.screenHeight, required this.screenWidth, required this.commentChapComic});
  final CommentChapComic commentChapComic;
  // ignore: prefer_typing_uninitialized_variables
  final screenWidth;
  // ignore: prefer_typing_uninitialized_variables
  final screenHeight;
  @override
  Widget build (BuildContext context) {
    final dcontroller = Get.find<DashboardController>();
    return GestureDetector(
      onTap: () async {
        await controller.fecchComentById(dcontroller.comic.value.id!, dcontroller.chapComic.value.id!, commentChapComic.id!);
        Get.to(ComicDetailView());
      },
      child: Container(
        padding: EdgeInsets.all(sizefix(10, screenWidth)),
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey),
        //     bottom: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey)
        //   ),
        // ),
        //width: screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(right: sizefix(10, screenWidth)),
              child: ClipOval(
                child: Image.network(
                  commentChapComic.hinhNen?.isNotEmpty == true 
                     ? commentChapComic.hinhNen! 
                    : 'https://cdn4.iconfinder.com/data/icons/aami-web-internet/64/aami13-44-512.png', 
                  height: sizefix(32, screenHeight),
                  width: sizefix(32, screenWidth),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 270,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(sizefix(10, screenHeight))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(text: commentChapComic.tenNguoiDung,fontWeight: FontWeight.bold, fontsize: sizefix(13, screenWidth),),
                  TagWidgetItems(score: int.parse(commentChapComic.soXu.toString())),
                  Padding(
                    padding:  EdgeInsets.only(top: sizefix(15, screenHeight)),
                    child: Container(child: TextCustom(text: commentChapComic.content,fontsize: sizefix(12, screenWidth),)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: sizefix(10, screenHeight)),
                    child: Row(
                      children: [
                        TextCustom(text: commentChapComic.ngay,fontsize: sizefix(11, screenWidth), color: Colors.grey,),
                        Padding(
                          padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(60, screenWidth)),
                          child: TextCustom(text: commentChapComic.thoiGian,fontsize: sizefix(11, screenWidth), color: Colors.grey,),
                        ),
                        Image.asset(AppImages.icChat, height: sizefix(20, screenWidth), width: sizefix(20, screenWidth),),
                        Padding(
                          padding: EdgeInsets.only(left: sizefix(3, screenWidth)),
                          child: TextCustom(text: "${commentChapComic.phanHoi!.length}",fontsize: sizefix(11, screenWidth), color: Colors.grey,),
                        )

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class ItemRate extends GetView{
  const ItemRate({super.key, required this.screenHeight, required this.screenWidth, required this.commentChapComic});
  final RateComic commentChapComic;
  // ignore: prefer_typing_uninitialized_variables
  final screenWidth;
  // ignore: prefer_typing_uninitialized_variables
  final screenHeight;
  @override
  Widget build (BuildContext context) {
    return Container(
      padding: EdgeInsets.all(sizefix(10, screenWidth)),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey),
          bottom: BorderSide(width: sizefix(0.1, screenWidth), color: Colors.grey)
        ),
      ),
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.only(right: sizefix(10, screenWidth)),
            child: ClipOval(
              child: Image.network(
                commentChapComic.hinhNen?.isNotEmpty == true 
                   ? commentChapComic.hinhNen! 
                  : 'https://cdn4.iconfinder.com/data/icons/aami-web-internet/64/aami13-44-512.png', 
                height: sizefix(32, screenHeight),
                width: sizefix(32, screenWidth),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(text: commentChapComic.userName,fontWeight: FontWeight.bold, fontsize: sizefix(13, screenWidth),),
              // Container(
              //   margin: EdgeInsets.only(top: sizefix(5, screenHeight)),
              //   padding: EdgeInsets.all(sizefix(5, screenHeight)),
              //   alignment: Alignment.center,
              //   height: sizefix(23, screenHeight),              
              //   decoration: BoxDecoration(
              //     color: AppColors.RedPrimary,
              //     borderRadius: BorderRadius.circular(sizefix(10, screenHeight))
              //   ),
              //   child: TextCustom(text: "Vương giả",fontsize: sizefix(10, screenWidth),color: AppColors.lightWhite, fontWeight: FontWeight.bold,),
              // ),
              StarRating(
                rating: double.parse(commentChapComic.starRate.toString()), // Điểm trung bình
                size: sizefix(25, screenWidth),
                color: Colors.yellow,
              ),
              Container(
              width: sizefix(260, screenWidth),
              child: TextCustom(text: commentChapComic.content,fontsize: sizefix(12, screenWidth), maxline: 2, overflow: TextOverflow.ellipsis,)),
              Row(
                children: [
                  TextCustom(text: commentChapComic.day,fontsize: sizefix(11, screenWidth), color: Colors.grey,),
                  Padding(
                    padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(60, screenWidth)),
                    child: TextCustom(text: commentChapComic.time,fontsize: sizefix(11, screenWidth), color: Colors.grey,),
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.flag_outlined, size: sizefix(20, screenWidth), color: Colors.grey,)
                  ),
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.send, size: sizefix(20, screenWidth), color: Colors.grey,)
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  StarRating({
    required this.rating,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];

    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        stars.add(Icon(
          Icons.star_rate_rounded,
          color: color,
          size: size,
        ));
      } else if (i - rating <= 1) {
        stars.add(Stack(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.white,
              size: size,
            ),
            ClipRect(
              clipper: _StarClipper((rating - (i - 1)) * size),
              child: Icon(
                Icons.star_rate_rounded,
                color: color,
                size: size,
              ),
            ),
          ],
        ));
      } else {
        stars.add(Icon(
          Icons.star_rate_rounded,
          color: Colors.white,
          size: size,
        ));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double width;

  _StarClipper(this.width);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}