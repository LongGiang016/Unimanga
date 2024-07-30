import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/global_widgets/Coin_items.dart';
import 'package:unimanga_app/app/modules/payment/repository/src/vnpay_flutter.dart';
import '../../global_widgets/text_custom.dart';
import 'controllers/payment_controllers.dart';
import 'result.dart'; 


class PaymentView extends GetView<PaymentControllers> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
     //print("${controller.selectedCoin.value!.giaTri!} ${controller.selectedCoin.value!.ten!}");
    Future<void> onPayment(double sotien, String ten, String xu) async {
    final paymentUrl = await VNPAYFlutter.instance.generatePaymentUrl (
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'WMG23MGB', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Pay $ten', //order info, default is Pay Order
      amount: sotien,
      returnUrl: 'https://etechstore-abe5c.web.app/', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: '7PQ48DCIOPTYWG1W8IBXIDW65Y1EHRTV', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType.HMACSHA512, //hash type. Default is HMACSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );
      await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VNPAYWebView(
          xu: xu,
          paymentUrl: paymentUrl,
          onPaymentSuccess: (params) {                  
},
          onPaymentError: (params) {
          },
        ),
      ),
    );
  }
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: sizefix(20, screenHeight)),
            height: sizefix(70, screenHeight),
            width: screenWidth,
            decoration: BoxDecoration(
              color: AppColors.RedPrimary,
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
              children: [
                IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.lightWhite,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: sizefix(10, screenWidth)),
                        child: TextCustom(
                          text: "Nạp Xu",
                          fontsize: sizefix(16, screenHeight),
                          color: AppColors.lightWhite
                        ),
                      )
              ],
            ),
          ),
          Container(          
            height: sizefix(450, screenHeight),
            width: screenHeight,
            padding: EdgeInsets.only(left: sizefix(10, screenWidth), right: sizefix(10, screenWidth)),
            child: Obx(() {
              if (controller.listcoin.isEmpty) {
                return const Center(child: CircularProgressIndicator()); 
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Số lượng cột
                  childAspectRatio: 4, // Tỉ lệ chiều rộng và chiều cao của mỗi item
                ),
                itemCount: controller.listcoin.length,
                itemBuilder: (context, index) {
                  return CoinItem(coin: controller.listcoin[index]);
                },
              );
            }),
          ),
          GestureDetector(      
            onTap: () {
              if(controller.selectedCoin.value == null){
                 Get.snackbar(
                    "Thông báo",
                    "Vui lòng chọn số tiền cần nạp",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
              }else{
                
              onPayment(double.parse(controller.selectedCoin.value!.giaTri!.toString()), controller.selectedCoin.value!.ten!, controller.selectedCoin.value!.xu!);
              }
            },
            child: Container( 
              margin: EdgeInsets.only(top: sizefix(20, screenHeight)),            
              alignment: Alignment.center,
              height: sizefix(50, screenHeight),
              width: sizefix(300, screenWidth), 
              decoration: BoxDecoration(
                color: AppColors.RedPrimary,
                borderRadius: BorderRadius.circular(sizefix(20, screenWidth))
              ), 
              child:  TextCustom(
                text: "Thanh Toán qua VnPay", color: AppColors.lightWhite, fontsize: sizefix(15, screenHeight), fontWeight: FontWeight.bold,)
            ),
          ),
      
        ],
      ),
    );
  }

}
