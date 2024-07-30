import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';

class ChapterProvider {

  Future<void> addChapComicReaded(
      String uiduser, String comicName, String comicId, String chapterId) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child("ChuongTruyenDaMoKhoa");

      DataSnapshot snapshot = await userRef.child(comicId).get();

      if (snapshot.exists) {
        dynamic snapshotValue = snapshot.value;
        if (snapshotValue is Map<Object?, Object?>) {
          // Xử lý trường hợp dữ liệu là một Map
          print("Snapshot value is a Map, not a List.");
          // Thực hiện các xử lý cần thiết, ví dụ:
          List<dynamic> chapters = [];
          (snapshotValue['ChuongTruyen'] as List<dynamic>).forEach((chapter) {
            chapters.add({"IdChuong": chapter['IdChuong']});
          });

          if (!chapters.any((chapter) => chapter['IdChuong'] == chapterId)) {
            chapters.add({"IdChuong": chapterId});
            await userRef.child(comicId).child('ChuongTruyen').set(chapters);
          }
        } else if (snapshotValue is List<dynamic>) {
          // Xử lý trường hợp dữ liệu là một List
          List<dynamic> chapters = List.from(snapshotValue);
          if (!chapters.any((chapter) => chapter['IdChuong'] == chapterId)) {
            chapters.add({"IdChuong": chapterId});
            await userRef.child(comicId).child('ChuongTruyen').set(chapters);
          }
        } else {
          // Xử lý trường hợp dữ liệu không rõ ràng
          print("Unexpected snapshot value type: ${snapshotValue.runtimeType}");
        }
      } else {
        // Truyện chưa tồn tại, thêm mới
        await userRef.child(comicId).set({
          "TenTruyen": comicName,
          "IdTruyen": comicId,
          "ChuongTruyen": [
            {"IdChuong": chapterId}
          ]
        });
      }

      print("Chapter $chapterId for comic $comicId added successfully.");
    } catch (e) {
      print("Error adding chapter to comic: $e");
    }
  }
  Future<bool> isChapterUnlocked(String uiduser, String comicId, String chapterId) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('TaiKhoan').child(uiduser).child("ChuongTruyenDaMoKhoa").child(comicId).child("ChuongTruyen");

      DataSnapshot snapshot = await userRef.get();
      if (snapshot.exists) {
        List<dynamic> chapters = snapshot.value as List<dynamic>;
        return chapters.any((chapter) => chapter['IdChuong'] == chapterId);
      }
      return false;
    } catch (e) {
      print("Error checking if chapter is unlocked: $e");
      return false;
    }
  }
  
}