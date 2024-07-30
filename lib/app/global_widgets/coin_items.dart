import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_function.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/models/coin_item.dart';

import '../modules/payment/controllers/payment_controllers.dart';
double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class CoinItem extends GetView<PaymentControllers> {
  const CoinItem({super.key, required this.coin});
  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        controller.selectCoin(coin); // Cập nhật trạng thái khi chọn item
      },
      child: Container(
        margin: EdgeInsets.only(bottom: sizefix(10, screenWidth)),
        padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
        height: sizefix(50, screenHeight),
        decoration: BoxDecoration(
          color: AppColors.lightWhite,
              
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: sizefix(25, screenWidth)),
              child: Obx(() => Radio(
                value: coin,
                groupValue: controller.selectedCoin.value,
                onChanged: (CoinModel? newValue) {
                  if (newValue != null) {
                    controller.selectCoin(newValue);
                    print(controller.selectedCoin.value!.ten!);
                  }
                },
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(text: coin.ten),
                TextCustom(text: "${coin.xu} Xu"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}