import 'package:unimanga_app/app/modules/payment/provider/payment_provider.dart';

import '../../../models/coin_item.dart';
import '../../../models/payment.dart';

class PaymentReposotory {
  PaymentReposotory({required this.provider});
  final PaymentProvider provider;
  
  Future<List<CoinModel>> getCoinList() =>
    provider.getCoinList();
  Future<List<PayMentModel>> getDanhSachThanhToan() =>
    provider.getDanhSachThanhToan();
}