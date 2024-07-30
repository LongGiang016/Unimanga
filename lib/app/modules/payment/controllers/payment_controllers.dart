import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import 'package:unimanga_app/app/modules/payment/repository/payment_reposotory.dart';

import '../../../models/coin_item.dart';
import '../../../models/payment.dart';

class PaymentControllers extends GetxController {
  PaymentControllers({ required this.reposotory});
  final PaymentReposotory reposotory;

   @override
    void onInit() {
      super.onInit();
      fetchCoinList();
      fetchPayMent();
    }

  var listcoin = <CoinModel>[].obs;
   var listpayment = <PayMentModel>[].obs;
     Future<void> fetchPayMent() async {
    try {
      List<PayMentModel> categories = await reposotory.getDanhSachThanhToan();
      listpayment.value = categories;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
   Future<void> fetchCoinList() async {
    try {
      List<CoinModel> coins = await reposotory.getCoinList();
      listcoin.value = coins;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
   var selectedCoin = Rxn<CoinModel>(); //

  void selectCoin(CoinModel coin) {
    selectedCoin.value = coin;
  }
  Future<void> addpayment(String gmail, String userName, String useruid, String sotien) async {
    try {
      final now = DateTime.now();
      final day = '${now.day}-${now.month}-${now.year}';
      final time = '${now.hour}:${now.minute}';
      // ignore: invalid_use_of_protected_member
      final id = (listpayment.value.length! + 1) -1;
      final newRating = PayMentModel(
        id:  id.toString(),
        idNguoiDung: useruid,
        ngayThanhToan: day,
        thoiGianThanhToan: time,
        tenNguoiDung: userName,
        soTien: sotien
      );
      listpayment.value.add(newRating);
      DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
      DatabaseReference userRef = accountRef.child("ThanhToan");
      await userRef.child(id.toString()).set(newRating.toMap());
    } catch (e) {
      print('Error adding commentcomic: $e');
    }
  }


}