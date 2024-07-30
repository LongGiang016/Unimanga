// import 'package:get/get.dart';
// import 'package:unimanga_app/app/modules/category/controllers/dashboard_controllers.dart';
// import 'package:unimanga_app/app/modules/signup/controllers/signup_controller.dart';
// import 'package:unimanga_app/app/modules/signup/provider/signup_provider.dart';
// import 'package:unimanga_app/app/modules/signup/repository/signup_repository.dart';
// import 'package:unimanga_app/app/modules/signup/views/SignUp.dart';

// class SignupBindings implements Bindings {
//   @override
//   Future<void> dependencies() async {
//     Get.lazyPut(() => SignupProvider());
//     Get.lazyPut(
//         () => SignupRepository(signupReponsitory: Get.find<SignupProvider>()));
//     Get.put(SignupController(authRepo: Get.find<SignupRepository>()));
//   }
// }
