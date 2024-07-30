import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/models/comic_model.dart';
import 'package:unimanga_app/app/models/rate_comic.dart';

import '../../../models/user.dart';
import '../../../models/chap_comic.dart';

class DashboardProvider {
final DateFormat dateFormat = DateFormat('dd-MM-yyyy h:mm');
Future<void> addRatingToBrosew(
      String uiduser, String comicName, String comicId, String idChap,String tenChuong, String idRating,String content,String soSao) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('DuyetBinhLuan').child("DanhGia");
        await userRef.child(comicId).set({
          "TenTruyen": comicName,
          "IdTruyen": comicId,
          "IdUser": uiduser,
          "idChuong": idChap,
          "TenChuong": tenChuong,
          "SoSao": soSao,
          "NoiDung":content,
          "IdDanhGia": idRating
          
        });
      print("Error add rating");
    } catch (e) {
      print("$e");
    }
  }


Future<List<ComicModel>> getComicListHot() async {
  try {
    DatabaseReference invoiceRef =
        stringFirebase.databaseconnect.ref('UniManga');
    DataSnapshot snapshot = (await invoiceRef.child('Truyen').once()).snapshot;
    List<ComicModel> comics = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      comics.add(ComicModel.fromJson(element as Map<Object?, Object?>));
    });
    comics.sort((a, b) => int.parse(b.luotXem!).compareTo(int.parse(a.luotXem!)));
    print(comics);
    return comics;
  } catch (e) {
    print('Error loading comic: $e');
    return [];
  }
}
Future<List<ComicModel>> getComicListNewUpdate() async {
  try {
    DatabaseReference invoiceRef =
        stringFirebase.databaseconnect.ref('UniManga');
    DataSnapshot snapshot = (await invoiceRef.child('Truyen').once()).snapshot;
    List<ComicModel> comics = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      comics.add(ComicModel.fromJson(element as Map<Object?, Object?>));
    });
     comics.sort((a, b) {
        final dateTimeA = dateFormat.parse('${a.ngayCapNhat} ${a.thoiGianCapNhat}');
        final dateTimeB = dateFormat.parse('${b.ngayCapNhat} ${b.thoiGianCapNhat}');
        return dateTimeB.compareTo(dateTimeA);
      });
      
    return comics;
  } catch (e) {
    print('Error loading comic: $e');
    return [];
  }
}

Future<List<RateComic>> getComicRate(String id) async {
  try {
    DatabaseReference invoiceRef =
        stringFirebase.databaseconnect.ref('UniManga');
    DataSnapshot snapshot = (await invoiceRef.child('Truyen').child(id).child("DanhGiaTruyen").once()).snapshot;

    List<RateComic> comics = [];
    List<dynamic> values = snapshot.value as List<dynamic>;

    values.forEach((element) {
      comics.add(RateComic.fromJson(element as Map<Object?, Object?>));
    });

    // Sắp xếp danh sách comics theo ngày và giờ (mới nhất trước)
    comics.sort((a, b) {
      // Kiểm tra giá trị day và time
      if (a.day == null || b.day == null) return 0;

      // Sử dụng toán tử null-aware để xử lý time có thể là null
      String timeA = a.time ?? "00:00";
      String timeB = b.time ?? "00:00";

      // Chuyển đổi ngày từ '7-7-2024' sang '2024-07-07'
      List<String> splitDateA = a.day!.split('-');
      List<String> splitDateB = b.day!.split('-');

      if (splitDateA.length != 3 || splitDateB.length != 3) {
        // Nếu không phải định dạng mong muốn, bỏ qua phần tử này
        return 0;
      }

      String formattedDateA = "${splitDateA[2]}-${splitDateA[1].padLeft(2, '0')}-${splitDateA[0].padLeft(2, '0')}";
      String formattedDateB = "${splitDateB[2]}-${splitDateB[1].padLeft(2, '0')}-${splitDateB[0].padLeft(2, '0')}";

      // Thêm "0" vào giờ nếu cần thiết
      String formattedTimeA = timeA.contains(":") ? timeA.padLeft(5, '0') : timeA;
      String formattedTimeB = timeB.contains(":") ? timeB.padLeft(5, '0') : timeB;

      // Kết hợp ngày và giờ
      String dateTimeA = "$formattedDateA $formattedTimeA";
      String dateTimeB = "$formattedDateB $formattedTimeB";

      DateTime? dateA = DateTime.tryParse(dateTimeA);
      DateTime? dateB = DateTime.tryParse(dateTimeB);

      // Kiểm tra nếu không thể phân tích được
      if (dateA == null || dateB == null) {
        return 0;
      }

      // Sắp xếp theo ngày và giờ mới nhất trước
      return dateB.compareTo(dateA);
    });

    return comics;
  } catch (e) {
    print('Error loading rate: $e');
    return [];
  }
}
Future<List<ComicModel>> searchComics(String keyword) async {
  try {
    DatabaseReference invoiceRef = stringFirebase.databaseconnect.ref('UniManga');
    DataSnapshot snapshot = (await invoiceRef.child('Truyen').once()).snapshot;
    List<ComicModel> comics = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      comics.add(ComicModel.fromJson(element as Map<Object?, Object?>));
    });

    if (keyword.isNotEmpty) {
      comics = comics.where((comic) =>
        comic.ten!.toLowerCase().contains(keyword.toLowerCase())).toList();
    }

    return comics;
  } catch (e) {
    print('Error searching comics: $e');
    return [];
  }
}

Future<List<ImageChap>> getImageChapComicById(String id, String idChuong) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(id).child('ChuongTruyen').child(idChuong).child('AnhTruyen').once()).snapshot;
    List<ImageChap> imagechaps = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      imagechaps.add(ImageChap.fromJson(element as Map<Object?, Object?>));
      
    });
    return imagechaps;
  } catch (e) {
    return [];
  }
    
}
Future<List<ChapComicModel>> getChapComicByIdComic(String idComic, String idChap) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(idComic).child('ChuongTruyen').child(idChap).once()).snapshot;
    List<ChapComicModel> imagechaps = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      imagechaps.add(ChapComicModel.fromJson(element as Map<Object?, Object?>));
      
    });
    return imagechaps;
  } catch (e) {
    return [];
  }
    
}

Future<ChapComicModel?> getComicChapById(String idComic, String idChap) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(idComic).child('ChuongTruyen').child(idChap).once()).snapshot;
    if (snapshot.value != null) {
      return ChapComicModel.fromJson(snapshot.value as Map<Object?, Object?>);
    } else {
      print("Comic with ID $idChap not found.");
      return null;
    }
  } catch (e) {
    print("Error loading comic by ID: $e");
    return null;
  }
}


Future<ComicModel?> getComicById(String id) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(id).once()).snapshot;
    if (snapshot.value != null) {
      return ComicModel.fromJson(snapshot.value as Map<Object?, Object?>);
    } else {
      print("Comic with ID $id not found.");
      return null;
    }
  } catch (e) {
    print("Error loading comic by ID: $e");
    return null;
  }
}

Future<List<ComicModel>> getComicListWithCate(String cate) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').once()).snapshot;
    List<ComicModel> comics = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      ComicModel comic = ComicModel.fromJson(element as Map<Object?, Object?>);
      if (comic.theLoai!.any((theLoai) => theLoai.tenTheLoai == cate)) {
        comics.add(comic);
      }
    });
    return comics;
  } catch (e) {
    print("Error loading comic with cate: $e");
    return [];
  }
}
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 Future<Users?> getUserByUid(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection('Users').doc(uid).get();
      if (documentSnapshot.exists) {
        return Users.fromSnapshot(documentSnapshot);
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<List<CommentChapComic>> getRateComicbyId(String id) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(id).child('DanhGiaTruyen').once()).snapshot;
    List<CommentChapComic> commentchaps = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      commentchaps.add(CommentChapComic.fromJson(element as Map<Object?, Object?>));
      
    });
    return commentchaps;
  } catch (e) {
    return [];
  }
    
}

  Future<List<ComicModel>> getFilterComic(String stt) async {
    try {
      DatabaseReference comicRef =
          stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DataSnapshot snapshot = (await comicRef.child('Truyen').once()).snapshot;
      List<ComicModel> comics = [];
      List<dynamic> values = snapshot.value as List<dynamic>;
      values.forEach((element) {
        ComicModel comic =
            ComicModel.fromJson(element as Map<Object?, Object?>);
        if (comic.theLoai!.any((theLoai) => theLoai.tenTheLoai == stt)) {
          comics.add(comic);
        }
      });
      return comics;
    } catch (e) {
      print("Error loading comic with cate: $e");
      return [];
    }
  }

   Future<List<Users>> getAllUserData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('Users').get();
      return querySnapshot.docs.map((doc) => Users.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Error getting user data: $e');
      rethrow;
    }
  }

 Future<List<Users>> getAllUserScores() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Users').where('score').get();
    return querySnapshot.docs.map((doc) => Users.fromSnapshot(doc)).toList();
  } catch (e) {
    print('Error getting all user scores: $e');
    rethrow;
  }
}

}