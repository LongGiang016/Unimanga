
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';
import 'package:unimanga_app/app/modules/infor_user/provider/info_user_provider.dart';
import 'package:unimanga_app/app/modules/payment/controllers/payment_controllers.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../payment1/result.dart';
class VNPAYWebView extends StatefulWidget {
  final String paymentUrl;
  final Function(Map<String, dynamic>)? onPaymentSuccess;
  final Function(Map<String, dynamic>)? onPaymentError;
  final Function()? onWebPaymentComplete;
  String? xu;
   VNPAYWebView({
    Key? key,
    required this.paymentUrl,
    this.onPaymentSuccess,
    this.onPaymentError,
    this.onWebPaymentComplete,
    this.xu,
  }) : super(key: key);

  @override
  _VNPAYWebViewState createState() => _VNPAYWebViewState();
}

class _VNPAYWebViewState extends State<VNPAYWebView> {
  late WebViewController _controller;
  @override
  void initState() {
    super.initState();
    final inforUser = Get.find<InforUserController>();
    final payment = Get.find<PaymentControllers>();
    final inforUserpro = Get.find<InforUserProvider>();
    int scroreUser = int.parse(inforUser.user.value!.score!.toString()); 
    int newScore = scroreUser + int.parse(widget.xu.toString());
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('vnp_ResponseCode')) {
              final params = Uri.parse(request.url).queryParameters;
              if (params['vnp_ResponseCode'] == '00') {
                widget.onPaymentSuccess?.call(params);
                inforUserpro.updateScoreByUid(firebaseUser!.uid!, newScore);
                payment.addpayment(firebaseUser.email!, inforUser.user.value!.name!, firebaseUser.uid,payment.selectedCoin.value!.giaTri!.toString());
                
              } else {
                widget.onPaymentError?.call(params);
              }
              widget.onWebPaymentComplete?.call();
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(result: params['vnp_ResponseCode'].toString()),
              ));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thanh toán'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}