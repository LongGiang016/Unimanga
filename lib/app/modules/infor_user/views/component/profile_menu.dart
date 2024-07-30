import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';

import '../../controller/user_controller.dart';
import '../../provider/info_user_provider.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  Color kPrimaryColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
class ButtonAutoReadComic extends GetView<InforUserController> {
  ButtonAutoReadComic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infor = Get.find<InforUserProvider>(); // Di chuyển đến bên trong hàm build
    final firebaseUser = FirebaseAuth.instance.currentUser; // Di chuyển đến bên trong hàm build

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: controller.kPrimaryColor.value,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(child: Text("Mở chương tự động")),
            Obx(() => FlutterSwitch(
              width: 55.0,
              height: 25.0,
              valueFontSize: 12.0,
              toggleSize: 18.0,
              value: controller.isSwitched.value,
              borderRadius: 30.0,
              padding: 4.0,
              showOnOff: false,
              onToggle: (val) {
                // Thực hiện hành động khi chuyển đổi trạng thái
                int newStatus = val ? 1 : 0;
                if (firebaseUser != null) {
                  infor.updateStatusAuToReadComic(firebaseUser.uid, newStatus);
                }
                // Cập nhật lại trạng thái trong GetX
                controller.toggleSwitch(val);
              },
            )),
          ],
        ),
      ),
    );
  }
}
class CoinView extends GetView<InforUserController> {
   CoinView({Key? key, required this.soxu}) : super(key: key);
   final soxu;

  @override
  Widget build(BuildContext context) {
    final infor = Get.find<InforUserProvider>(); // Di chuyển đến bên trong hàm build
    final firebaseUser = FirebaseAuth.instance.currentUser; // Di chuyển đến bên trong hàm build

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: controller.kPrimaryColor.value,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(child: Text("Số Xu")),
            TextCustom(text: soxu, color: Colors.yellow, fontsize: 15),
            SizedBox(width: 10,),
            Icon(Icons.copyright_rounded, color: Colors.yellow, size: 15,)
          ],
        ),
      ),
    );
  }
}