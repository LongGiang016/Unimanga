import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unimanga_app/app/modules/filter_comic/repository/fillter_comic_repository.dart';

import '../../../models/category_comic_model.dart';
import '../../../models/comic_model.dart';

class FilterController extends GetxController {
  FilterController({required this.repository});
   @override
  void onInit() {
    super.onInit();
    fetchComicList();
    fetchComicStatus("Hoàn thành");
  }
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy h:mm');
  var selectedCategories = <categoryComicModel>[].obs;
  final FilterReponsitory repository;
  var selectedFilter = 'Tất cả'.obs;
  var selectedRankFilter = 'Ngày cập nhật'.obs;
  var selectedStatusTemp = "Tất cả".obs;
  var selectedRankTemp = 'Ngày cập nhật'.obs;
  var statusValue = 0.obs;
  var rankValue = 0.obs;
  var isFetching = false.obs;
  var listComicStatus = <ComicModel>[].obs;
  var listComicAll =  <ComicModel>[].obs;
  var listComicFiltered = <ComicModel>[].obs;
  
  void UpadetStatus(String filter){
    selectedStatusTemp.value = filter;
  }
  void UpadetRankfilter(String filter){
    selectedRankTemp.value = filter;
  }
  void setSelecRankFiter(String filter){
    selectedRankFilter.value = filter;
  }
  void setStatusValue(int value){
    statusValue.value = value;
  }

  void setRankValue(int value){
    rankValue.value = value;
  }

  void setSelectedFilter(String filter) {
    selectedFilter.value = filter;
  }
  Future<void> fetchComicList() async {
    try {
      List<ComicModel> comics = await repository.getAllComicList();
      listComicAll.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
  Future<void> fetchComicStatus(String status) async {
    try {
      List<ComicModel> comics = await repository.getComicListStatus(status);
      listComicStatus.value = comics;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void setCategoryFilter(String category) {
  selectedCategories.value = [categoryComicModel(tenTheLoai: category)];
  isFetching.value = true;
  applyFilters();
  }

    

  GetSRankValue(){
    if(rankValue.value == 0){
      return "Ngày cập nhật";
    }
    else if(rankValue.value == 1){
      return "Lượt xem";
    }
    else{
      return "Lượt thích";
    }
  }
    GetStatusValue(){
    if(statusValue.value == 0){
      return "Tất cả";
    }
    else if(statusValue.value == 1){
      return "Hoàn thành";
    }
    else{
      return "Đang cập nhật";
    }
  }

 void applyFilters() {
  var filtered = listComicAll.where((comic) {
    // Kiểm tra lọc theo trạng thái
    if (selectedFilter.value != "Tất cả" && comic.tinhTrang != selectedFilter.value) {
      return false;
    }

    if (selectedCategories.isNotEmpty) {
      List<String?> comicCategoryNames = comic.theLoai!.map((category) => category.tenTheLoai).toList();
      bool checkCategory = selectedCategories.any((category) =>
          !comicCategoryNames.contains(category.tenTheLoai));

      if (checkCategory) {
        return false;
      }
    }

    return true;
  }).toList();

  // Tiếp tục sắp xếp danh sách filtered theo selectedRankFilter
  switch (selectedRankFilter.value) {
    case 'Lượt xem':
      filtered.sort((a, b) => int.parse(b.luotXem!).compareTo(int.parse(a.luotXem!)));
      break;
    case 'Lượt thích':
      filtered.sort((a, b) => int.parse(b.luotDanhGia!).compareTo(int.parse(a.luotDanhGia!)));
      break;
    case 'Ngày cập nhật':
      filtered.sort((a, b) {
        final dateTimeA = dateFormat.parse('${a.ngayCapNhat} ${a.thoiGianCapNhat}');
        final dateTimeB = dateFormat.parse('${b.ngayCapNhat} ${b.thoiGianCapNhat}');
        return dateTimeB.compareTo(dateTimeA);
      });
      break;
  }

  listComicFiltered.assignAll(filtered);
}
}
