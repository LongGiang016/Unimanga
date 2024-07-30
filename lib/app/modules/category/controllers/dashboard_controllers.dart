
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:unimanga_app/app/models/category_comic_model.dart';
import 'package:unimanga_app/app/modules/category/repository/dashboard_repository.dart';


class CategoryController extends GetxController{
  void onInit() {
    super.onInit();
    fetchCatogoryComic();
    print(listCatorogy.value);
  } 
 final CategoryReponsitory categoryReponsitory;
 CategoryController({required this.categoryReponsitory});
 var listCatorogy = <categoryComicModel>[].obs;

  Future<void> fetchCatogoryComic() async {
    try {
      List<categoryComicModel> categories = await categoryReponsitory.getCategoryList();
      listCatorogy.value = categories;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

}
