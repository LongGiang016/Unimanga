import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../models/user.dart';
import '../../dashboard/views/dashboard_views.dart';
import '../../home/views/home_views.dart';
import '../repository/info_user_repository.dart';

class InforUserController extends GetxController {
  InforUserController({required this.inforUserRepository});

  final InforUserRepository inforUserRepository;

  var user = Rxn<Users>();
  var checkAuto = 0.obs;
  
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (firebaseUser != null) {
      fetchUser(firebaseUser!.uid);
      ever(user, (_) {
      updateSwitchState();
    });
    } else {
      print('Không có tài khoản.');
    }
  }
  Rx<Color> kPrimaryColor = Rx<Color>(Colors.black); 
  RxBool isSwitched = false.obs; 

  void updateSwitchState() {
    if (user.value!.statuscomic! == 1) {
      isSwitched.value = true;
    } else {
      isSwitched.value = false;
    }
  }
  // Các phương thức để thay đổi giá trị
  void changePrimaryColor(Color newColor) {
    kPrimaryColor.value = newColor;
  }

  void toggleSwitch(bool newValue) {
    isSwitched.value = newValue;
    // Thêm các xử lý khác nếu cần
  }
  Future<void> fetchUser(String uid) async {
    try {
      Users? fetchedUser = await inforUserRepository.getUserByUid(uid);
      if (fetchedUser != null) {
        user.value = fetchedUser;
      } else {
        print('Không tìm thấy');
      }
    } catch (e) {
      print('Error fetching user information: $e');
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut().then((_) {
      user.value = null;
      Get.offAll(() => DashboardView());
      Get.offAll(() => HomeView());
    }).catchError((error) {
      print("Đăng xuất không thành công: $error");
    });
  }
}
