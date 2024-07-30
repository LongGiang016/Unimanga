import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import '../../../models/user.dart';
import '../repository/signin_repository.dart';



class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final authRepo = Get.put(SigninRepository());
  Future<void> loginAccount(Users user) async {
    await authRepo.loginAccount(user);
  }
}
