import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';

import '../../../models/chap_comic.dart';

class CommentProvider {
Future<void> addCommmentToBrosew(
      String uiduser, String comicName, String comicId, String idChap,String tenChuong, String idRating,String content) async {
    try {
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child('DuyetBinhLuan').child("BinhLuan");
        await userRef.child(idRating).set({
          "TenTruyen": comicName,
          "IdTruyen": comicId,
          "IdUser": uiduser,
          "idChuong": idChap,
          "TenChuong": tenChuong,
          "NoiDung":content,
          "IdComment": idRating
          
        });
      print("add comment suss");
    } catch (e) {
      print(" Lỗi $e");
    }
  }

  Future<List<CommentChapComic>> getCommentChapById(String id, String idChuong) async {
  try {
    DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(id).child('ChuongTruyen').child(idChuong).child('BinhLuan').once()).snapshot;
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

Future<CommentChapComic?> getComentById(String idComic, String idChap, String idComment) async {
  try {
     DatabaseReference comicRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
    DataSnapshot snapshot = (await comicRef.child('Truyen').child(idComic).child('ChuongTruyen').child(idChap).child('BinhLuan').child(idComment).once()).snapshot;
    if (snapshot.value != null) {
      return CommentChapComic.fromJson(snapshot.value as Map<Object?, Object?>);
    } else {
      print("Comic with ID $idComment not found.");
      return null;
    }
  } catch (e) {
    print("Error loading comic by ID: $e");
    return null;
  }
}

}