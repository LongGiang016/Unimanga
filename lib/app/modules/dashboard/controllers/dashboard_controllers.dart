import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import 'package:unimanga_app/app/models/chap_comic.dart';
import 'package:unimanga_app/app/modules/dashboard/repository/dashboard_repository.dart';
import '../../../models/rate_comic.dart';
import '../../../models/user.dart';
import '../../../models/comic_model.dart';
import '../../home/views/home_views.dart';

class DashboardController extends GetxController {
  final DashboardReponsitory dashboardReponsitory;

  //Timer? _timer;
  DashboardController({required this.dashboardReponsitory});

  var user = Rxn<Users>();
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchComicList();
    fetchComicListAction('Action');
    fetchComicListAventature('Adventure');
    fetchComicListIseKai("Isekai");
    fetchComicListFantasy('Fantasy');
    fetchScoresUser();
    fetchListTopUser();
    fetchComicListNewUpdate();
    fetchTopUser();
  }
  // @override
  // void onClose() {
  //   _timer?.cancel();
  //   super.onClose();
  // }
  var rating = 0.obs;
  var searchHistory = <String>[].obs;
  var isFetching = false.obs;
  var searchResults = <ComicModel>[].obs;
  var listchap = <ImageChap>[].obs;
  var listcomic = <ComicModel>[].obs;
  var listcomicNewUpdate = <ComicModel>[].obs;
  var listcomicAction = <ComicModel>[].obs;
  var listcomicFantasy = <ComicModel>[].obs;
  var listcomicAdVenture = <ComicModel>[].obs;
  var listcomicIsekai = <ComicModel>[].obs;
  var listuser = <Users>[].obs;
  var listtop = <Users>[].obs;
  var listscore = <Users>[].obs;
  var listsRate = <RateComic>[].obs;
  var comic = ComicModel().obs;
  var chapComic = ChapComicModel().obs;
  var chapCmicTest = ChapComicModel().obs;
  final RxInt _selectedChip = 0.obs;
    var isFullView = false.obs;
  int get selectedChip => _selectedChip.value;
  set selectedChip(int value) {
    _selectedChip.value = value;
    fetchFilteredComics();
  }

   Future<void> fetchComicList() async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicList();
      listcomic.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
   Future<void> fetchComicListNewUpdate() async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicListNewUpdate();
      listcomicNewUpdate.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
  
  
   Future<void> fetchComicRate(String id) async {
    try {
      List<RateComic> comics = await dashboardReponsitory.getComicRate(id);
      listsRate.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }



 double calculateAverageRating(List<RateComic> danhGiaTruyen) {
  if (danhGiaTruyen.isEmpty) {
    return 0.0; // Trả về 0 nếu danh sách rỗng để tránh chia cho 0
  }

  int sumOfRatings = 0;
  for (var danhGia in danhGiaTruyen) {
    sumOfRatings += int.parse(danhGia.starRate.toString());
  }

  double averageRating = sumOfRatings / danhGiaTruyen.length;
  
  // Chỉ lấy một chữ số sau dấu chấm thập phân
  return double.parse(averageRating.toStringAsFixed(1));
}
  final Rx<List<ComicModel>> _comics = Rx<List<ComicModel>>([]);
  List<ComicModel> get comics => _comics.value;

  final List<String> statusOptions = ['Tất cả', 'Đang cập nhật', 'Hoàn thành'];

  Future<void> fetchFilteredComics() async {
    String selectedStatus = statusOptions[selectedChip];
    if (selectedStatus == 'Tất cả') {
      _comics.value = await dashboardReponsitory.getComicList();
    } else {
      _comics.value = await dashboardReponsitory.getFilterComic(selectedStatus);
    }
  }

  Future<void> fetchUser(String uid) async {
    try {
      Users? fetchedUser = await dashboardReponsitory.getUserByUid(uid);
      if (fetchedUser != null) {
        user.value = fetchedUser;
      } else {
        print('User information not found');
      }
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }
  Future<void> fetchImageChap(String id, String idChap) async {
    try {
      List<ImageChap> comics = await dashboardReponsitory.getImageChapComicById(id, idChap);
      listchap.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
 Future<void> fecchComicChapById(String id, String idChap) async {
    try {
      ChapComicModel? comics = await dashboardReponsitory.getComicChapById(id, idChap);
      chapComic.value = comics!;
    } catch (e) {
      print('Error fetching comic: $e');
    }
  }

  // Future<void> fetchChapComic(String id, String idChap) async {
  //   try {
  //     List<ChapComicModel> comics = await dashboardReponsitory.getChapComicByIdComic(id, idChap);
  //     chapComic.value = comics;
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //   }
  // }




  Future<void> fecchComic(String id) async {
    try {
      ComicModel? comics = await dashboardReponsitory.getComicById(id);
      comic.value = comics!;
    } catch (e) {
      print('Error fetching comic: $e');
    }
  }

  

  Future<void> fetchComicListAction(String cate) async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicListWithCate(cate);
      listcomicAction.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
   Future<void> fetchComicListAventature(String cate) async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicListWithCate(cate);
      listcomicAdVenture.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
  Future<void> fetchComicListIseKai(String cate) async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicListWithCate(cate);
      listcomicIsekai.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
  Future<void> fetchComicListFantasy(String cate) async {
    try {
      List<ComicModel> comics = await dashboardReponsitory.getComicListWithCate(cate);
      listcomicFantasy.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
 Future<void> searchComic(String keyword) async {
    if (keyword.isEmpty) {
      searchResults.clear();
    } else {
      try {
        // Lọc danh sách đã tải trước đó
        List<ComicModel> filteredComics = listcomic.where((comic) {
          return comic.ten!.toLowerCase().contains(keyword.toLowerCase());
        }).toList();
        searchResults.value = filteredComics;
      } catch (e) {
        print('Error searching comics: $e');
      }
    }
  }


  void setFullView(bool value) {
    isFullView.value = value;
  }
  void addSearchHistory(String keyword) {
    if (!searchHistory.contains(keyword)) {
      searchHistory.add(keyword);
    }
  }
  void updateRating(int newRating) {
    rating.value = newRating;
  }
  Future<void> addRating(String coment, String userName, String useruid, String userAva) async {
    try {
      // Lấy thông tin ngày giờ hiện tại
      final now = DateTime.now();
      final day = '${now.day}-${now.month}-${now.year}';
      final time = '${now.hour}:${now.minute}';
      final id = (comic.value.rateComic!.length + 1) -1;

      // Thông tin người dùng (cập nhật với thông tin của bạn)
  

      // Tạo đối tượng RateComic mới
      final newRating = RateComic(
        id:  id.toString(),
        idUser: useruid,
        day: day,
        time: time,
        starRate: rating.value.toString(),
        content: coment,
        hinhNen: userAva, // Thêm hình nền nếu có
        userName: userName,
        status: "1"
      );

      // Thêm đánh giá mới vào danh sách đánh giá hiện có
      comic.value.rateComic?.add(newRating);
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('Truyen').child(comic.value.id!).child("DanhGiaTruyen");
      await userRef.child(id.toString()).set(newRating.toMap());

      comic.refresh();

      rating.value = 0;
    } catch (e) {
      print('Error adding rating: $e');
    }
  }

  Future<void> fetchListTopUser() async {
    try {
      List<Users> fetchedUsers = await dashboardReponsitory.getAllUserData();
      listuser.value = fetchedUsers
        ..sort((a, b) => b.score!.compareTo(a.score!));

      if (listuser.length > 10) {
        listuser.value = listuser.sublist(3, 10);
      } else {
        listuser.value = listuser.sublist(3);
      }
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }

  Future<void> fetchTopUser() async {
    try {
      List<Users> fetchedUsers = await dashboardReponsitory.getAllUserData();
      listtop.value = fetchedUsers
        ..sort((a, b) => b.score!.compareTo(a.score!));
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }

  Future<void> fetchScoresUser() async {
    try {
      List<Users> fetchedUsers = await dashboardReponsitory.getAllUserScores();
      listscore.value = fetchedUsers;
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }
   Future<void> updateLike(
      String id , String newlike) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('Truyen').child(id);

      //DataSnapshot snapshot = await userRef.child(comicId).get();
        await userRef.update({
          "LuotDanhGia": newlike
        });
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }

  Future<void> updateView(
      String id , String newlike) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('Truyen').child(id);

      //DataSnapshot snapshot = await userRef.child(comicId).get();
        await userRef.update({
          "LuotXem": newlike
        });
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }


}



  // Các phương thức khác ở đây nếu cần

  

