import 'package:firebase_database/firebase_database.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/global_widgets/Coin_items.dart';
import 'package:unimanga_app/app/models/coin_item.dart';
import 'package:unimanga_app/app/models/payment.dart';

class PaymentProvider {

  Future<List<CoinModel>> getCoinList() async {
  try {
    DatabaseReference invoiceRef =
        stringFirebase.databaseconnect.ref('UniManga');
    DataSnapshot snapshot = (await invoiceRef.child('Xu').once()).snapshot;
    List<CoinModel> coins = [];
    List<dynamic> values = snapshot.value as List<dynamic>;
    values.forEach((element) {
      coins.add(CoinModel.fromJson(element as Map<Object?, Object?>));
    });
    print(coins);
    return coins;
  } catch (e) {
    print('Error loading coin list: $e');
    return [];
  }
}
Future<List<PayMentModel>> getDanhSachThanhToan() async {
  try {
      DatabaseReference invoiceRef =
           stringFirebase.databaseconnect.ref('UniManga');
      DataSnapshot snapshot = (await invoiceRef.child('ThanhToan').once()).snapshot;

      List<PayMentModel> invoices = [];
      List<dynamic> values = snapshot.value as List<dynamic>;
      values.forEach((element) {
        invoices.add(PayMentModel.fromJson(element as Map<Object?, Object?>));
      });
      print(invoices);
      return invoices;
    } catch (e) {
      print('Error loading invoices: $e');
      return [];
    }


}
}