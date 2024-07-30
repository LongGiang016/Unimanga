import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/filter_comic/provider/fillter_comic_provider.dart';
import 'package:unimanga_app/app/modules/filter_comic/repository/fillter_comic_repository.dart';

import '../controllers/fillter_comic_controllers.dart';

class FilterComicbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterComicProvider());
    Get.lazyPut(
        () => FilterReponsitory (provider: Get.find<FilterComicProvider>()));
    Get.put(FilterController(
          repository: Get.find<FilterReponsitory>(),
    ));
  }
}