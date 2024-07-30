import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/global_widgets/tag_custom.dart';
import 'package:unimanga_app/app/modules/payment/mainpayment.dart';
import 'package:unimanga_app/app/modules/update_pass/views/changepass.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../global_widgets/appbar_custom.dart';
import '../../../auth/firebase_service.dart';
import '../../../dashboard/bindings/dashboard_bindings.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../../../home/views/home_views.dart';
import '../../../payment/bindings/payment_binding.dart';
import '../../../signin/views/signin.dart';
import '../../../signup/views/signup.dart';
import '../../bindings/info_user_bindings.dart';
import '../../controller/user_controller.dart';
import 'my_profile.dart';
import 'profile_menu.dart';

class IntroWidgetWithoutLogos extends GetView<DashboardController> {
  const IntroWidgetWithoutLogos({super.key});
  @override
  Widget build(BuildContext context) {
    double topPadding = MediaQuery.of(context).size.height * 0.20;
    DashBoardBindings().dependencies();
    InforUserbinding().dependencies();
    final inforUserController = Get.find<InforUserController>();

    return Column(children: [
      Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
        IntroWidgetWithoutLogo(),
        Obx(() {
          final user = inforUserController.user.value;
          return user == null
              ? Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: ListTile(
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/unimanga-37d5f.appspot.com/o/Users%2Flogo.jpg?alt=media&token=d2aa5b5e-ed06-4b0f-9c57-fcebe2699088',
                            ),
                            fit: BoxFit.cover,
                            width: 60.0,
                            height: 60.0,
                          ),
                        ),
                        radius: 30.0,
                      ),
                      title: Text(
                        "Khách thập phương",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(" Đăng nhập/ Đăng ký để sử dụng")),
                )
              : Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage(user.imageUrl!),
                          fit: BoxFit.cover,
                          width: 60.0,
                          height: 60.0,
                        ),
                      ),
                      radius: 30.0,
                    ),
                    //trailing: TextCustom(text: user.score!.toString(), color: AppColors.yellowPrimary, fontsize: 25, ),
                    title: Text(
                      "${user.name!}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: TagWidgetItems(score: user.score!),
                  ),
                );
        })
      ])
    ]);
  }
}

class WidgetProfileMenu extends GetView<DashboardController> {
  const WidgetProfileMenu(
      {super.key, required this.screenHeight, required this.screenWidth});
  final double screenWidth;
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    InforUserbinding().dependencies();
    final auth = Get.put(AuthService());
    final inforUserController = Get.find<InforUserController>();
    return Column(children: [
      Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
        Obx(() {
          final user = inforUserController.user.value;
          return user == null
              ? Column(
                  children: [
                    ProfileMenu(
                      text: "Đăng nhập",
                      icon: "assets/images/icons/log_out.svg",
                      press: () {
                        auth.logout(context, nextRoute: () => Login_Screen());
                      },
                    ),
                    ProfileMenu(
                      text: "Đăng ký",
                      icon: "assets/images/icons/log_out.svg",
                      press: () {
                        auth.logout(context, nextRoute: () => SignUp());
                      },
                    ),
                    ProfileMenu(
                      text: "Trợ giúp",
                      icon: "assets/images/icons/question_mark.svg",
                      press: () {
                        const link =
                            "https://www.facebook.com/profile.php?id=61562410632615&mibextid=LQQJ4d";
                        launchUrl(Uri.parse(link),
                            mode: LaunchMode.inAppBrowserView);
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    CoinView(soxu: user.score.toString()),
                    ButtonAutoReadComic(),
                    
                    ProfileMenu(
                      text: "Nạp Xu",
                      icon: "assets/images/icons/user_icon.svg",
                      press: () =>
                          {Get.to(PaymentView(), binding: PaymentBinding())},
                    ),
                    ProfileMenu(
                      text: "Thông tin tài khoản",
                      icon: "assets/images/icons/user_icon.svg",
                      press: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyProfile(),
                          ),
                        )
                      },
                    ),
                    ProfileMenu(
                      text: "Đổi mật khẩu",
                      icon: "assets/images/icons/settings.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(),
                          ),
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Trợ giúp",
                      icon: "assets/images/icons/question_mark.svg",
                      press: () {
                        const link =
                            "https://www.facebook.com/profile.php?id=61562410632615&mibextid=LQQJ4d";
                        launchUrl(Uri.parse(link),
                            mode: LaunchMode.inAppBrowserView);
                      },
                    ),
                    ProfileMenu(
                      text: "Đăng xuất",
                      icon: "assets/images/icons/log_out.svg",
                      press: () {
                        auth.logout(context, nextRoute: () => HomeView());
                      },
                    ),
                  ],
                );
        })
      ])
    ]);
  }
}
