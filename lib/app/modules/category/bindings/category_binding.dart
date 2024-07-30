
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/category/controllers/category_controllers.dart';
import 'package:unimanga_app/app/modules/category/provider/category_provider.dart';
import 'package:unimanga_app/app/modules/category/repository/category_repository.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryProvider());
    Get.lazyPut(() => CategoryReponsitory(categoryReponsitory: Get.find<CategoryProvider>()));
    Get.put(CategoryController(categoryReponsitory: Get.find<CategoryReponsitory>()));
  }
}
