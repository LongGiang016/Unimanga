import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/global_widgets/filter.dart';
import 'package:unimanga_app/app/modules/auth/firebase_service.dart';
import 'package:unimanga_app/app/modules/home/views/home_views.dart';
import 'package:unimanga_app/app/modules/infor_user/views/component/my_profile.dart';
import 'package:unimanga_app/app/modules/list_comic/views/ListManga.dart';
import 'package:unimanga_app/app/modules/signup/views/signup.dart';
import '../../../constants/app_function.dart';
import '../../dashboard/bindings/dashboard_bindings.dart';
import '../../signin/views/signin.dart';
import '../bindings/info_user_bindings.dart';
import '../controller/user_controller.dart';
import 'component/profile_menu.dart';
import 'component/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double sizefix(double size, double screen) {
    return Sizefix.sizefix(size, screen);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    DashBoardBindings().dependencies();
    InforUserbinding().dependencies();
    final inforUserController = Get.find<InforUserController>();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Future<void> _refresh() async {
      await inforUserController.fetchUser(firebaseUser!.uid);
    }

    return RefreshIndicator(
        onRefresh: _refresh,
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                IntroWidgetWithoutLogos(),
                const SizedBox(height: 20),
                WidgetProfileMenu(
                    screenHeight: screenHeight, screenWidth: screenWidth)
              ],
            ),
          ),
        ));
  }
}
