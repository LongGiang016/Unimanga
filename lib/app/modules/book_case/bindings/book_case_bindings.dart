
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/book_case/controllers/book_case_controller.dart';
import 'package:unimanga_app/app/modules/category/controllers/category_controllers.dart';
import 'package:unimanga_app/app/modules/category/provider/category_provider.dart';
import 'package:unimanga_app/app/modules/category/repository/category_repository.dart';

import '../provider/book_case_provider.dart';
import '../repository/book_case_repository.dart';

class BookCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookCaseProvider());
    Get.lazyPut(() => BookCaseReponsitory(provider: Get.find<BookCaseProvider>()));
    Get.put(BookCaseController(reponsitory: Get.find<BookCaseReponsitory>()));
  }
}
