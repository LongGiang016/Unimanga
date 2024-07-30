import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/payment/controllers/payment_controllers.dart';
import 'package:unimanga_app/app/modules/payment/provider/payment_provider.dart';
import 'package:unimanga_app/app/modules/payment/repository/payment_reposotory.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentProvider());
    Get.lazyPut(() => PaymentReposotory(provider: Get.find<PaymentProvider>()));
    Get.put(PaymentControllers(reposotory: Get.find<PaymentReposotory>()));
  }
}
