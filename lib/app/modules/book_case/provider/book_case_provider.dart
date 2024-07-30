import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import 'package:unimanga_app/app/global_widgets/comic_items.dart';

import '../../../models/comic_model.dart';

class BookCaseProvider {
String TruyenDaLuu = "TruyenDaLuu";
String TruyenDaDoc = "TruyenDaDoc";
String TruyenDaThich = "TruyenDaThich";

Future<List<ComicModel>> getComicListSaved(String uid) async {
 try {
    DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DatabaseReference userRef = accountRef.child('TaiKhoan').child(uid).child("TruyenDaLuu");

    DataSnapshot snapshot = await userRef.get();
    List<ComicModel> comics = [];

    if (snapshot.exists) {
      if (snapshot.value is Map<Object?, Object?>) {
        Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
        data.forEach((key, value) {
          comics.add(ComicModel.fromJson(value as Map<Object?, Object?>));
        });
      } else if (snapshot.value is List<Object?>) {
        List<Object?> data = snapshot.value as List<Object?>;
        for (var value in data) {
          if (value != null && value is Map<Object?, Object?>) {
            comics.add(ComicModel.fromJson(value));
          }
        }
      }
    }

    return comics;
  } catch (e) {
    print("Error fetching saved comics: $e");
    return [];
  }
}
Future<ComicModel?> getComicReaderById(String uid, String idComic) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('TaiKhoan').child(uid).child(TruyenDaDoc).child(idComic).once()).snapshot;
    if (snapshot.value != null) {
      return ComicModel.fromJson(snapshot.value as Map<Object?, Object?>);
    } else {
      print("Comic with ID $idComic not found.");
      return null;
    }
  } catch (e) {
    print("Error loading comic by ID: $e");
    return null;
  }
}
Future<List<ComicModel>> getComicListSaved1(String uid) async {
  try {
    DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DatabaseReference userRef = accountRef.child('TaiKhoan').child(uid).child("TruyenDaLuu");
    DataSnapshot snapshot = await userRef.get();

    List<ComicModel> comics = [];

    if (snapshot.exists) {
      // Kiểm tra loại dữ liệu của snapshot.value
      if (snapshot.value is Map) {
        // Duyệt qua các phần tử trong Map
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          if (value is Map) {
            comics.add(ComicModel.fromJson(value));
          }
        });
      } else if (snapshot.value is List) {
        // Duyệt qua các phần tử trong List
        List<dynamic> values = snapshot.value as List<dynamic>;
        for (var element in values) {
          if (element is Map) {
            comics.add(ComicModel.fromJson(element));
          }
        }
      }
    }

    return comics;
  } catch (e) {
    print('Error loading comic: $e');
    return [];
  }
}
Future<List<ComicModel>> getComicListLiked(String uid) async {
  try {
    DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DatabaseReference userRef = accountRef.child('TaiKhoan').child(uid).child("TruyenDaThich");
    DataSnapshot snapshot = await userRef.get();
    
    List<ComicModel> comics = [];

    if (snapshot.exists) {
      
      if (snapshot.value is Map) {
       
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          if (value is Map) {
            comics.add(ComicModel.fromJson(value));
          }
        });
      } else if (snapshot.value is List) {
      
        List<dynamic> values = snapshot.value as List<dynamic>;
        for (var element in values) {
          if (element is Map) {
            comics.add(ComicModel.fromJson(element));
          }
        }
      }
    }

    return comics;
  } catch (e) {
    print('Error loading comic: $e');
    return [];
  }
}
Future<List<ComicModel>> getComicListReaded(String uid) async {
 try {
    DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DatabaseReference userRef = accountRef.child('TaiKhoan').child(uid).child(TruyenDaDoc);

    DataSnapshot snapshot = await userRef.get();
    List<ComicModel> comics = [];

    if (snapshot.exists) {
      if (snapshot.value is Map<Object?, Object?>) {
        Map<Object?, Object?> data = snapshot.value as Map<Object?, Object?>;
        data.forEach((key, value) {
          comics.add(ComicModel.fromJson(value as Map<Object?, Object?>));
        });
      } else if (snapshot.value is List<Object?>) {
        List<Object?> data = snapshot.value as List<Object?>;
        for (var value in data) {
          if (value != null && value is Map<Object?, Object?>) {
            comics.add(ComicModel .fromJson(value));
          }
        }
      }
    }

    return comics;
  } catch (e) {
    print("Error fetching saved comics: $e");
    return [];
  }
}
 Future<void> addComicIntoComicLiked(
      String uiduser, String comicName, String comicId, String imageUrl, String comicList, String soChuong) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child(comicList);

      //DataSnapshot snapshot = await userRef.child(comicId).get();
        await userRef.child(comicId).set({
          "Ten": comicName,
          "Id": comicId,
          "AnhTruyen": imageUrl,
          "SoChuong": soChuong,
          
        });
      print("Chapter  comic $comicId added successfully.");
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }
 Future<void> addComicIntoComicSave(
      String uiduser, String comicName, String comicId, String imageUrl, String comicList, String soChuong) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child(comicList);

      //DataSnapshot snapshot = await userRef.child(comicId).get();
        await userRef.child(comicId).set({
          "Ten": comicName,
          "Id": comicId,
          "AnhTruyen": imageUrl,
          "SoChuong": soChuong,
          
        });
      print("Chapter  comic $comicId added successfully.");
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }
  Future<void> addComicIntoComicReaded(
      String uiduser, String comicName, String comicId, String imageUrl, String comicList, String chapId, String chapName) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child(comicList);
      DatabaseReference comicRef = userRef.child(comicId);
      DataSnapshot snapshot = await comicRef.get();
      if(snapshot.exists){
        await comicRef.update({
        "ChapId": chapId,
        "ChapName": chapName
        });
         print("Chapter info of comic $comicId updated successfully.");
      }
      else{
        await userRef.child(comicId).set({
          "Ten": comicName,
          "Id": comicId,
          "AnhTruyen": imageUrl,
          "SoChuong": chapId,
          "ChapName":chapName,
          "ChapId": chapId,
          
        });
      print("Chapter  comic $comicId added successfully.");     
      }
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }
  Future<bool> isComicExists(String uiduser, String comicId) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child("TruyenDaLuu");

      DataSnapshot snapshot = await userRef.child(comicId).get();

      return snapshot.exists;
    } catch (e) {
      print("Error checking if comic exists: $e");
      return false;
    }
  }
  Future<bool> isComicLikedExists(String uiduser, String comicId) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child("TruyenDaThich");

      DataSnapshot snapshot = await userRef.child(comicId).get();

      return snapshot.exists;
    } catch (e) {
      print("Error checking if comic exists: $e");
      return false;
    }
  }
  Future<void> removeComicFromSaved(String uiduser, String comicId, String s) async {
    try {
      DatabaseReference accountRef =
          stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef =
          accountRef.child('TaiKhoan').child(uiduser).child("TruyenDaLuu");

      await userRef.child(comicId).remove();
      print("Comic $comicId removed successfully.");
    } catch (e) {
      print("Error removing comic from saved: $e");
    }
  }
  Future<void> removeComicFromLiked(String uiduser, String comicId, String s) async {
    try {
      DatabaseReference accountRef =
          stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef =
          accountRef.child('TaiKhoan').child(uiduser).child("TruyenDaThich");

      await userRef.child(comicId).remove();
      print("Comic $comicId removed successfully.");
    } catch (e) {
      print("Error removing comic from saved: $e");
    }
  }

}