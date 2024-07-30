// import 'package:get/get.dart';
// import 'package:unimanga_app/app/modules/category/controllers/dashboard_controllers.dart';
// import 'package:unimanga_app/app/modules/category/provider/dashboard_provider.dart';
// import 'package:unimanga_app/app/modules/category/repository/dashboard_repository.dart';
// import 'package:unimanga_app/app/modules/signin/controllers/signin_controller.dart';
// import 'package:unimanga_app/app/modules/signin/provider/signin_provider.dart';
// import 'package:unimanga_app/app/modules/signin/repository/signin_repository.dart';

// class LoginBinding implements Bindings {
//   @override
//   void dependencies() async {
//     Get.put(() => SigninProvider());
//     Get.lazyPut(
//         () => SigninRepository(signinReponsitory: Get.find<SigninProvider>()));
//     Get.put(LoginController(provider: Get.find<SigninRepository>()));
//   }
// }
