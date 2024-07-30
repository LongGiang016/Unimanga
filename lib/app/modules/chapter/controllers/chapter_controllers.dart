import 'package:get/get.dart';
import 'package:unimanga_app/app/models/chap_comic.dart';
import 'package:unimanga_app/app/modules/chapter/repository/Chapter_reposotory.dart';

import '../views/chapter_view.dart';

class ChapterController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    isUpdated.value = false;
  }
  ChapterController({required this.chapterRepository});
  final ChapterRepository chapterRepository;
  var isContainerVisible = true.obs;
  var isUpdated = false.obs;
   var isUpdatedscore0 = false.obs;
  var isUpdateLockChap = false.obs;
  var isFetching = false.obs;
  var idChap = 0.obs;
  void toggleContainerVisibility() {
    isContainerVisible.value = !isContainerVisible.value;
  }
    var isNextChapterPressed = false.obs;

  var chapComicModel = ChapComicModel().obs;
  void goToNextChapter(List<ChapComicModel> chapters , int currentIndex) {
    if (currentIndex < chapters.length - 1) {
      ChapComicModel nextChapter = chapters[currentIndex + 1];
      chapComicModel.value = nextChapter;
    } else {
      print('Đây là chương cuối cùng.');
    }
    isNextChapterPressed.value = true; // Cập nhật trạng thái của nút
    update(); 
  }
  
  

}

