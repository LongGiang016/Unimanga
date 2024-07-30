import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:unimanga_app/app/constants/app_fonts.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/auth/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widget = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widget);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthService()));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: AppFonts.verLag),
      home: Center(
        child: CircularProgressIndicator(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
