
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/book_case/bindings/book_case_bindings.dart';
import 'package:unimanga_app/app/modules/chapter/bindings/chapter_binding.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import 'package:unimanga_app/app/modules/comic_detail/views/detail_child/chappter_page.dart';
import 'package:unimanga_app/app/modules/comic_detail/views/detail_child/detail_page.dart';
import 'package:unimanga_app/app/modules/comic_detail/views/detail_child/rate_comic_view.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import '../../../constants/index.dart';
import '../../../models/chap_comic.dart';
import '../../../models/comic_model.dart';
import '../../book_case/controllers/book_case_controller.dart';
import '../../chapter/views/chapter_view.dart';


double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ComicDetail extends GetView<DashboardController> {
  ComicDetail({super.key, this.IdChap, this.ChapName});
  var IdChap;
  var ChapName;
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    ChapterBinding().dependencies();
    BookCaseBinding().dependencies();
    final bookCaseController = Get.find<BookCaseController>();
    final dashboardController = Get.find<DashboardController>();

    List<ChapComicModel>? listchap = dashboardController.comic.value.chapComicModel!;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    print("Truyện của id là : ${controller.comic.value.id}");
    print("Truyên ${bookCaseController.comic.value.chapId}");
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            color: AppColors.lightWhite,
            child: RefreshIndicator(
               onRefresh: () => controller.fecchComic(controller.comic.value.id!),
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: AppColors.lightWhite,
                      leading: GestureDetector(
                         onTap: () {
                           bookCaseController.comic.value = ComicModel();
                           Get.back();
                         },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: sizefix(32, screenHeight)),
                          child: Icon(Icons.arrow_back_ios_new, color:  AppColors.lightWhite,),
                        ),
                      ),
                      expandedHeight:sizefix(300, screenHeight), // Chiều cao ban đầu của SliverAppBar
                      floating: true,
                      pinned: true, // Giữ AppBar luôn hiển thị
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: sizefix(180, screenHeight),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(controller.comic.value.anhBiaTruyen!),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: sizefix(80, screenHeight),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                            
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: sizefix(165, screenHeight)),
                                  height: sizefix(100, screenHeight),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightWhite,
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: sizefix(12, screenHeight),right: sizefix(12, screenHeight), top: sizefix(30, screenHeight)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                             Obx(() { return TextCustom(text: controller.comic.value.luotDanhGia, fontsize: sizefix(20, screenWidth),fontWeight: FontWeight.bold,); }),
                                            TextCustom(text: "Số like", color: Colors.grey, fontsize: sizefix(10, screenWidth),)
                                          ],
                                        ),
                                        Column(
                                          children: [
                                             Obx(() { return TextCustom(text: controller.comic.value.luotXem, fontsize: sizefix(20, screenWidth),fontWeight: FontWeight.bold,); }),
                                            TextCustom(text: "Độ hot", color: Colors.grey, fontsize: sizefix(10, screenWidth),)
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                             await controller.fetchComicRate(controller.comic.value.id!);
                                            print(controller.listsRate.value);
                                            Get.to(RateComicView());
                                          },
                                          child: Obx(() {
                                            return Column(

                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    TextCustom(
                                                      text: "${controller.calculateAverageRating(controller.comic.value.rateComic!)}",
                                                      fontsize: sizefix(20, screenWidth),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    Icon(
                                                      Icons.star_rate_rounded,
                                                      color: AppColors.yellowPrimary,
                                                      size: sizefix(20, screenWidth),
                                                    ),
                                                  ],
                                                ),
                                                TextCustom(
                                                  text: "${controller.comic.value.rateComic!.length} đánh giá",
                                                  color: Colors.grey,
                                                  fontsize: sizefix(10, screenWidth),
                                                ),
                                              ],
                                            );
                                          }),
                                        ),
                                    
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 10,
                              color: AppColors.gray,
                            )
                          ],
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(kToolbarHeight),
                        child: Material(
                          color: AppColors.lightWhite, // Thay đổi màu nền ở đây
                          child: TabBar(
                            labelColor: AppColors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: AppColors.RedPrimary,
                            dividerColor: AppColors.lightWhite,
                            tabs: const [
                              Tab(text: 'Chi tiết'),
                              Tab(text: 'Chương'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    DetailPage(),
                    ChappterPage(screenHeight: screenHeight, screenWidth: screenWidth)
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            alignment: Alignment.center ,
            height: sizefix(50, screenHeight),
            child: 
            firebaseUser == null
            ?GestureDetector(
               onTap: () async {
               await controller.fetchImageChap(controller.comic.value.id!, "0");
               Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 100),
                      pageBuilder: (context, animation, secondaryAnimation) => ChapterView(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        chapComicModel: 
                          listchap[1],
                           
                        comic: controller.comic.value,
                      ),
                    ),
                  );
              },
              child: Container(
                alignment: Alignment.center,
                height: sizefix(40, screenHeight),
                width: sizefix(300, screenWidth), 
                decoration: BoxDecoration(
                  color: AppColors.RedPrimary,
                  borderRadius: BorderRadius.circular(sizefix(20, screenWidth))
                ), 
                child:  TextCustom(
                  text: "Bắt đầu đọc", color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)
                ),
            )
            : bookCaseController.comic.value.ten == null
            ?GestureDetector(
              onTap: () async {
              await controller.fetchImageChap(controller.comic.value.id!, "0");
              
               Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 100),
                      pageBuilder: (context, animation, secondaryAnimation) => ChapterView(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                         chapComicModel: 
                         listchap![0],
                           
                        comic: controller.comic.value,
                        
                      ),
                    ),
                  );
              },           
              child: Container(
                alignment: Alignment.center,
                height: sizefix(40, screenHeight),
                width: sizefix(300, screenWidth), 
                decoration: BoxDecoration(
                  color: AppColors.RedPrimary,
                  borderRadius: BorderRadius.circular(sizefix(20, screenWidth))
                ), 
                child: TextCustom(text: 'Bắt đầu đọc',color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)
                // TextCustom(
                //   text: "Đọc tiếp ${bookCaseController.comic.value.chapName}", color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)
                ),
                
            )
            :GestureDetector(
              onTap: () async {
               await controller.fecchComicChapById(controller.comic.value.id!, bookCaseController.comic.value.chapId!);
               await controller.fecchComic(controller.comic.value.id!);
               await controller.fetchImageChap(controller.comic.value.id!, controller.chapComic.value.id!.toString());
               await bookCaseController.fetchComicDetail(firebaseUser.uid, controller.comic.value.id!);
               List<ChapComicModel>? listchap = controller.comic.value.chapComicModel;
              int newlike = int.parse(controller.comic.value.luotXem.toString()) + 1;
              dashboardController.updateView(controller.comic.value.id!,newlike.toString());
               Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 100),
                      pageBuilder: (context, animation, secondaryAnimation) => ChapterView(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                         chapComicModel: 
                         listchap![int.parse(controller.chapComic.value.id!)],
                           
                        comic: controller.comic.value,
                        
                      ),
                    ),
                  );
              },           
              child: Container(
                alignment: Alignment.center,
                height: sizefix(40, screenHeight),
                width: sizefix(300, screenWidth), 
                decoration: BoxDecoration(
                  color: AppColors.RedPrimary,
                  borderRadius: BorderRadius.circular(sizefix(20, screenWidth))
                ), 
                child:   Obx(() => TextCustom(text: 'Đọc tiếp ${bookCaseController.comic.value.chapName}',color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)), 
                // TextCustom(
                //   text: "Đọc tiếp ${bookCaseController.comic.value.chapName}", color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)
                ),
                
            )
          )
        ),
      ),
    );
  }
}

