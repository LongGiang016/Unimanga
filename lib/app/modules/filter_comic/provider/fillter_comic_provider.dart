import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';

import '../../../models/comic_model.dart';

class FilterComicProvider {
  Future<List<ComicModel>> getComicListHot(String string) async {
    try {
      DatabaseReference invoiceRef = stringFirebase.databaseconnect.ref('UniManga');
      DataSnapshot snapshot = (await invoiceRef.child('Truyen').once()).snapshot;
      List<ComicModel> comics = [];
      List<dynamic> values = snapshot.value as List<dynamic>;
      values.forEach((element) {
        comics.add(ComicModel.fromJson(element as Map<Object?, Object?>));
      });

      // Lọc danh sách truyện với TinhTrang "Đang cập nhật"
      List<ComicModel> updatingComics = comics.where((comic) => comic.tinhTrang == string).toList();

      // Sắp xếp danh sách truyện theo luotXem

      print(updatingComics);
      return updatingComics;
    } catch (e) {
      print('Error loading comic: $e');
      return [];
    }
  }
  Future<List<ComicModel>> getAllComicList() async {
    try {
      DatabaseReference comicRef = stringFirebase.databaseconnect.ref('UniManga');
      DataSnapshot snapshot = (await comicRef.child('Truyen').once()).snapshot;
      List<ComicModel> comics = [];
      List<dynamic> values = snapshot.value as List<dynamic>;
      
      for (var element in values) {
        comics.add(ComicModel.fromJson(element as Map<Object?, Object?>));
      }
      
      print(comics);
      return comics;
    } catch (e) {
      print('Error loading comic list: $e');
      return [];
    }
  }
  
}