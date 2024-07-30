
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_function.dart';
import '../../../global_widgets/index.dart';
import '../../../models/comic_model.dart';
import '../../book_case/controllers/book_case_controller.dart';
import '../../comic_detail/views/comic_detail.dart';
import '../../dashboard/controllers/dashboard_controllers.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class SearchView extends GetView<DashboardController> {
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    TextEditingController _searchController = TextEditingController();
     User? firebaseUser = FirebaseAuth.instance.currentUser;
    final bookCaseController = Get.find<BookCaseController>(); 
    return Scaffold(
      body: Container(
        color: AppColors.lightWhite,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: sizefix(10, screenHeight)),
                height: sizefix(70, screenHeight),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.lightWhite,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.searchResults.clear();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.blackPrimary,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                      child: TextCustom(
                        text: "Tìm kiếm truyện",
                        fontsize: sizefix(16, screenHeight),
                        color: AppColors.blackPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(           
                controller: _searchController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.gray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  labelText: "Nhập từ khóa tìm kiếm",
                  labelStyle: TextStyle(
                  color: AppColors.blackPrimary,
                  ),
                ),
                onChanged: (value) {
                  dashboardController.searchComic(value);
                  dashboardController.setFullView(false);
                  print(dashboardController.isFullView.value);
                },
                onSubmitted: (value) {
                  dashboardController.setFullView(true);
                  dashboardController.searchComic(value);
                  dashboardController.update(); 

                },
              ),
            ),
            Expanded(
              child: Obx(() {
                if (dashboardController.searchResults.isEmpty) {
                  return Center(child: Text("Không có kết quả tìm kiếm"));
                }
                return ListView.builder(
                  itemCount: dashboardController.searchResults.length,
                  itemBuilder: (context, index) {
                    ComicModel comic = dashboardController.searchResults[index];
                    return dashboardController.isFullView.value
                        ? GestureDetector(
                           onTap: () async {
                            if(firebaseUser == null){
                            }
                            else{
                              bookCaseController.fetchComicDetail(firebaseUser.uid, comic.id!);
                            }
                            await controller.fecchComic(comic.id!);
                             controller.searchResults.clear();
                            _searchController.clear();
                            Get.to(() => ComicDetail(IdChap: comic.chapId, ChapName: comic.chapName,),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500), 
                            );
                          },
                          child: ListTile(
                              leading: Image.network(comic.anhTruyen!),
                              title: Text(comic.ten!),
                              subtitle: Text("Chương ${comic.soChuong!}"),
                            ),
                        )
                        : GestureDetector(
                            onTap: () async {
                            if(firebaseUser == null){
                            }
                            else{
                              bookCaseController.fetchComicDetail(firebaseUser.uid, comic.id!);
                            }
                            await controller.fecchComic(comic.id!);
                            controller.searchResults.clear();
                            _searchController.clear();
                            Get.to(() => ComicDetail(IdChap: comic.chapId, ChapName: comic.chapName,),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500), 
                            );
                          },
                          child: ListTile(
                              title: Text(comic.ten!),
                            ),
                        );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}