//  import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class MyWidget extends StatefulWidget {
//   @override
//   _MyWidgetState createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   bool _showQr = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  Column(
//       children: [
//         ElevatedButton(
//           onPressed: _showQrCode,
//           child: Text('Nhấn tôi'),
//         ),
//         SizedBox(height: 20),
//         _buildQrCode(),
//       ],
//     ),   
//     );

//   }

//   void _showQrCode() {
//     setState(() {
//       _showQr = true;
//     });
//   }

//  Widget _buildQrCode() {
//   if (!_showQr) {
//     return Container();
//   }
//   return QrImageView(
//     // Pass the QrCode object properties here
//     data: 'https://qr.vietcombank.com.vn/QR/1022064638',
//     version: QrVersions.auto,
//     size: 200.0,
//   );
// }

// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  static const platform = MethodChannel('my_flutter_project');

  Future<void> openSdk() async {
    try {
        await platform.invokeMethod('openSdk', {
            'url': 'https://sandbox.vnpayment.vn/testsdk/',
            'tmn_code': 'FAHASA03',
            'scheme': 'resultactivity',
            'is_sandbox': false,
        });
        print('Sent openSdk command to native'); // Log khi gửi lệnh thành công
    } on PlatformException catch (e) {
        print("Failed to invoke openSdk: '${e.message}'.");
    }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: openSdk,
            child: Text('Open SDK'),
          ),
        ),
      ),
    );
  }
}