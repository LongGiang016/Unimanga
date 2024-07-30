import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/models/comic_model.dart';

class DashboardProvider {
 Future<List<ComicModel>> getDanhSachTruyen() async {
  final reference = stringFirebase.databaseconnect.ref('UniManga/Truyen');
  final event = await reference.get();
  List<ComicModel> danhSachTruyen = [];

  if (event.exists) {
    var data = event.value as Map<dynamic, dynamic>;
    data.forEach((key, value) {
      if (value is Map<dynamic, dynamic>) {
        ComicModel comic = ComicModel.fromJson(Map<String, dynamic>.from(value));
        danhSachTruyen.add(comic);
      }
    });
  } else {
    print('Lỗi lấy dữ liệu TheLoai');
  }
  print("danh sách truyện sao khi lấy: $danhSachTruyen");
  return danhSachTruyen;
}

}