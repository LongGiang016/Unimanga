import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unimanga_app/app/modules/auth/firebase_service.dart';
import 'package:unimanga_app/app/modules/home/views/home_views.dart';
import 'package:unimanga_app/app/modules/signin/views/signin.dart';

import '../../../models/user.dart';

class Vertification extends StatefulWidget {
  Vertification({super.key});

  @override
  State<Vertification> createState() => _VertificationState();
}

class _VertificationState extends State<Vertification> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthService());
    auth.sendEmailVerificationLink();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              auth.logout(context, nextRoute: () => HomeView());
            },
          ),
          title: Text('Quay lại')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset('assets/animations/email.json',
              repeat: true, reverse: true, fit: BoxFit.fill),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Chúng tôi đã gửi vào tài khoản của bạn',
                  ),
                  TextSpan(
                    text: '\nmột liên kết xác thực tài khoản.',
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
