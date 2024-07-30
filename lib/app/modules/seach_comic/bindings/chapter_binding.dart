import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/chapter/controllers/chapter_controllers.dart';
import 'package:unimanga_app/app/modules/chapter/provider/chapter_provider.dart';
import 'package:unimanga_app/app/modules/chapter/repository/Chapter_reposotory.dart';

class ChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChapterProvider());
    Get.lazyPut(() => ChapterRepository(chapterProvider: Get.find<ChapterProvider>()));

    Get.lazyPut(() => ChapterController(chapterRepository: Get.find<ChapterRepository>()));
  }
  
}
