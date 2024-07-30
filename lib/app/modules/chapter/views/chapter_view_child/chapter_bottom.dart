import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import '../../../../constants/index.dart';
import '../../../../global_widgets/chappter_item.dart';
import '../../../../global_widgets/text_custom.dart';
import '../../../../models/chap_comic.dart';
import '../../../../models/comic_model.dart';
import '../../../comment/controllers/comment_controllers.dart';
import '../../../comment/views/comment_chapter_views.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../chapter_view.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

// ignore: must_be_immutable
class ChappterBottom extends GetView<ChapterController> {
  ChappterBottom({
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
    final dashboardController = Get.find<DashboardController>();
    final commentController = Get.find<CommentController>();

    List<ChapComicModel>? listchap = dashboardController.comic.value.chapComicModel!;
    int currentIndex = listchap.indexOf(chapComicModel);
    bool isLastChapter = currentIndex == listchap.length - 1;
    bool isFirstChapter = currentIndex == 0;

    print("List of chapters: ${listchap.map((chap) => chap.tenChuong).toList()}");
  print("Current chapter model: ${chapComicModel.tenChuong}");

print("Current index: $currentIndex");
    bool areEqual = chapComicModel == dashboardController.chapComic.value;
    print("Are chapComicModel and dashboardController.chapComic.value equal? $areEqual");

    print(currentIndex);
    print(chapComicModel.id);
    print(chapComicModel.tenChuong);
    
    void showLoadingDialog() {
      Get.dialog(
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: CircularProgressIndicator( color:  AppColors.RedPrimary,),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }


    void hideLoadingDialog() {
      Get.back();
    }

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: sizefix(10, screenWidth),
        right: sizefix(10, screenWidth),
        top: sizefix(20, screenHeight),
      ),
      width: screenWidth,
      height: sizefix(70, screenHeight),
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: sizefix(500, screenHeight),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: sizefix(15, screenWidth),
                            right: sizefix(15, screenWidth),
                            top: sizefix(15, screenWidth),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextCustom(
                                text: "${comic!.chapComicModel!.length} chương",
                                fontsize: sizefix(15, screenWidth),
                              ),
                              Row(
                                children: [
                                  TextCustom(
                                    text: "Cũ nhất",
                                    fontsize: sizefix(12, screenWidth),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                                    child: TextCustom(
                                      text: "Mới nhất",
                                      fontsize: sizefix(12, screenWidth),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: sizefix(20, screenHeight)),
                            child: RefreshIndicator(
                              onRefresh: fetchItems,
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 6,
                                ),
                                itemCount: listchap.length,
                                itemBuilder: (context, index) {
                                  return ChappterItem(
                                    screenHeight: screenHeight,
                                    screenWidth: screenWidth,
                                    chappter: listchap[index],
                                    comic: comic,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Column(
              children: [
                Icon(Icons.format_list_bulleted, size: sizefix(25, screenWidth)),
                TextCustom(text: "Chương", fontsize: sizefix(10, screenWidth)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              showLoadingDialog();
              await commentController.fetchCommentChap(comic!.id!, chapComicModel.id!);
              hideLoadingDialog();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentChapComicView(
                    chapComicModel: chapComicModel,
                    comic: comic,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Image.asset(AppImages.icChat, height: sizefix(25, screenWidth), width: sizefix(25, screenWidth),),
                TextCustom(text: "Bình luận", fontsize: sizefix(10, screenWidth)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (currentIndex > 0) {
                  showLoadingDialog();
                  await Future.delayed(const Duration(seconds: 1));
                  hideLoadingDialog();

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => ChapterView(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        chapComicModel: listchap[currentIndex - 1],
                        comic: comic,
                      ),
                      
                    ),
                  );

                  dashboardController.listchap.value = listchap[currentIndex - 1].imageChap!;
                  controller.isUpdated.value = false;
                
              }
            },
            child: Column(
              children: [
                isFirstChapter
                    ? Icon(Icons.navigate_before_sharp, size: sizefix(25, screenWidth), color: Colors.grey)
                    : Icon(Icons.navigate_before_sharp, size: sizefix(25, screenWidth)),
                isFirstChapter
                    ? TextCustom(text: "Chương trước", fontsize: sizefix(10, screenWidth), color: Colors.grey)
                    : TextCustom(text: "Chương trước", fontsize: sizefix(10, screenWidth)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (currentIndex < listchap.length - 1) {
                showLoadingDialog();
                await Future.delayed(const Duration(seconds: 2));
                hideLoadingDialog();
                Navigator.push(
                  context,
                  // MaterialPageRoute(
                  //   builder: (context) => ChapterView(
                  //     screenHeight: screenHeight,
                  //     screenWidth: screenWidth,
                  //     chapComicModel: listchap[currentIndex + 1],
                  //     comic: comic,
                  //   ),
                  // ),
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>  ChapterView(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        chapComicModel: listchap[currentIndex + 1],
                        comic: comic,
                      ),
                     
                    ),
                );

                dashboardController.listchap.value = listchap[currentIndex + 1].imageChap!;
                controller.isUpdated.value = false;
              }
            },
            child: Column(
              children: [
                isLastChapter
                    ? Icon(Icons.navigate_next_sharp, size: sizefix(25, screenWidth), color: Colors.grey)
                    : Icon(Icons.navigate_next_sharp, size: sizefix(25, screenWidth)),
                isLastChapter
                    ? TextCustom(text: "Chương sau", fontsize: sizefix(10, screenWidth), color: Colors.grey)
                    : TextCustom(text: "Chương sau", fontsize: sizefix(10, screenWidth)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



Future<void> fetchItems() async {}
