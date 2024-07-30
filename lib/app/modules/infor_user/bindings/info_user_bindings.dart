import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/infor_user/provider/info_user_provider.dart';
import 'package:unimanga_app/app/modules/infor_user/repository/info_user_repository.dart';

import '../controller/user_controller.dart';


class InforUserbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InforUserProvider());
    Get.lazyPut(
        () => InforUserRepository(inforUserProvider: Get.find<InforUserProvider>()));
    Get.put(InforUserController(
      inforUserRepository: Get.find<InforUserRepository>(),
    ));
  }
}
