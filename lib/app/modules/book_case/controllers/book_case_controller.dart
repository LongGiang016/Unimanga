
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/models/comic_model.dart';
import '../repository/book_case_repository.dart';


class BookCaseController extends GetxController{
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  @override
    void onInit()  {
      super.onInit();
      if (firebaseUser != null) {
        fetchComicSaved(firebaseUser!.uid);
        fetchComicSaved1(firebaseUser!.uid);
        fetchComicReaded(firebaseUser!.uid);
        fetchComicLiked(firebaseUser!.uid);
        print(listComicSaved.value);
      } else {
        print('Không có tài khoản.');
      }
    } 
  final BookCaseReponsitory reponsitory;
  BookCaseController({required this.reponsitory});
  var listComicSaved = <ComicModel>[].obs;
  var listComicLiked = <ComicModel>[].obs;
  var listComicSaved1 = <ComicModel>[].obs;
  var listComicRead = <ComicModel>[].obs;
  var isFetching = false.obs;
  var chapId = 0.obs;
  var comicId = 0.obs;
  var chapName = "".obs;
  var comic = ComicModel().obs;

  Future<void> fetchComicDetail(String uid, String idComic) async {
      try {
        ComicModel? comics = await reponsitory.getComicReaderById(uid, idComic);
        comic.value = comics!;
      } catch (e) {
        print('Error fetching : $e');
      }
    }
  
  Future<void> fetchComicSaved(String uid) async {
      try {
        List<ComicModel> comics = await reponsitory.getComicListSaved(uid);
        listComicSaved.value = comics;
      } catch (e) {
        print('Error fetching : $e');
      }
    }
     Future<void> fetchComicSaved1(String uid) async {
      try {
        List<ComicModel> comics = await reponsitory.getComicListSaved1(uid);
        listComicSaved1.value = comics;
      } catch (e) {
        print('Error fetching : $e');
      }
    }
    Future<void> fetchComicLiked(String uid) async {
      try {
        List<ComicModel> comics = await reponsitory.getComicListLiked(uid);
        listComicLiked.value = comics;
      } catch (e) {
        print('Error fetching : $e');
      }
    }

  Future<void> fetchComicReaded(String uid) async {
      try {
        List<ComicModel> comics = await reponsitory.getComicListReaded(uid);
        listComicRead.value = comics;
      } catch (e) {
        print('Error fetching : $e');
      }
    }

}
