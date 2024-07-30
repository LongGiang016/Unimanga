import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import 'package:unimanga_app/app/modules/comment/repository/comment_reposotory.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';

import '../../../models/chap_comic.dart';

class CommentController extends GetxController {
  CommentController({required this.commentRepository});
  final CommentRepository commentRepository;
  void onInit() {
    super.onInit();
  }
  var listCommentChap = <CommentChapComic>[].obs;
  final dashController = Get.find<DashboardController>();
  final chapterController = Get.find<ChapterController>();
  
  var comment= CommentChapComic().obs;

   Future<void> fecchComentById(String id, String idChap, String idCom) async {
    try {
      CommentChapComic? comics = await commentRepository.getComentById(id, idChap, idCom);
      comment.value = comics!;
    } catch (e) {
      print('Error fetching comic: $e');
    }
  }

  Future<void> fetchCommentChap(String id, String idChap) async {
    try {
      List<CommentChapComic> commentchaps = await commentRepository.getCommentChapById(id, idChap);
      listCommentChap.value = commentchaps;
    } catch (e) {
      print('Error fetching comments chao: $e');
    }
  }
  Future<void> addComment(String coment, String userName, String useruid, String userAva, String soXu, String chapId) async {
    try {
      final now = DateTime.now();
      final day = '${now.day}-${now.month}-${now.year}';
      final time = '${now.hour}:${now.minute}';
      // ignore: invalid_use_of_protected_member
      final id = (listCommentChap.value.length + 1) -1;
      final newRating = CommentChapComic(
        id:  id.toString(),
        idNguoiDung: useruid,
        ngay: day,
        thoiGian: time,
        soXu: soXu,
        content: coment,
        hinhNen: userAva, 
        tenNguoiDung: userName,
        status: "0",
        phanHoi: const []
      );

      // Thêm đánh giá mới vào danh sách đánh giá hiện có
      dashController.chapComic.value.comment!.add(newRating);
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('Truyen').child(dashController.comic.value.id!).child("ChuongTruyen").child(chapId).child("BinhLuan");
      await userRef.child(id.toString()).set(newRating.toMap());

    } catch (e) {
      print('Error adding commentcomic: $e');
    }
  }
  Future<void> addCommentRepon(String coment, String userName, String useruid, String userAva, String soXu) async {
    try {
      final now = DateTime.now();
      final day = '${now.day}-${now.month}-${now.year}';
      final time = '${now.hour}:${now.minute}';
      // ignore: invalid_use_of_protected_member
      final id = (comment.value.phanHoi!.length! + 1) -1;
      final newRating = CommentChapComic(
        id:  id.toString(),
        idNguoiDung: useruid,
        ngay: day,
        thoiGian: time,
        soXu: soXu,
        content: coment,
        hinhNen: userAva, 
        tenNguoiDung: userName,
        status: "0",
        phanHoi: []
      );
      comment.value.phanHoi!.add(newRating);
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('Truyen').child(dashController.comic.value.id!).child("ChuongTruyen").child(dashController.chapComic.value.id!).child("BinhLuan").child(comment.value.id!).child("PhanHoi");
      await userRef.child(id.toString()).set(newRating.toMap());

    } catch (e) {
      print('Error adding commentcomic: $e');
    }
  }
}