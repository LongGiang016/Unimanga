import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import 'package:unimanga_app/app/models/category_comic_model.dart';

class CategoryProvider {
Future<List<categoryComicModel>> getDanhSachTheLoai() async {
  try {
      DatabaseReference invoiceRef =
           stringFirebase.databaseconnect.ref('UniManga');
      DataSnapshot snapshot = (await invoiceRef.child('TheLoai').once()).snapshot;

      List<categoryComicModel> invoices = [];
      List<dynamic> values = snapshot.value as List<dynamic>;
      values.forEach((element) {
        invoices.add(categoryComicModel.fromJson(element as Map<Object?, Object?>));
      });
      print(invoices);
      return invoices;
    } catch (e) {
      print('Error loading invoices: $e');
      return [];
    }
}
}