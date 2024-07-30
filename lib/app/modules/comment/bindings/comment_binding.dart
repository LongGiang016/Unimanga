import 'package:get/get.dart';
import '../controllers/comment_controllers.dart';
import '../provider/comment_provider.dart';
import '../repository/comment_reposotory.dart';

class CommentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommentProvider());
    Get.lazyPut(() => CommentRepository(commentProvider: Get.find<CommentProvider>()));
    Get.put(CommentController(commentRepository: Get.find<CommentRepository>()));
  }
}