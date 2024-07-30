import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:unimanga_app/app/modules/book_case/controllers/book_case_controller.dart';
import 'package:unimanga_app/app/modules/book_case/views/book_case_child/book_case_liked.dart';
import 'package:unimanga_app/app/modules/book_case/views/book_case_child/book_save.dart';
import '../../../constants/index.dart';
import '../bindings/book_case_bindings.dart';
import 'book_case_child/book_case_readed_view.dart';

double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class BookCaseView extends GetView<BookCaseController> {
  const BookCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    BookCaseBinding().dependencies();
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Số lượng tab
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(sizefix(60, screenHeight)), // Độ cao mong muốn của AppBar
            child: AppBar(
              backgroundColor: Colors.white,
              bottom: const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.red, // Màu chỉ báo của tab được chọn
                tabs: [
                  Tab(text: 'Đã Lưu',),
                  Tab(text: 'Đã Đọc'),
                  Tab(text: 'Đã Thích'),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              ComicSaved(),
              ComicReadedView(),
              ComicLiked(),
            ],
          ),
        ),
      ),
    );
  }
}
