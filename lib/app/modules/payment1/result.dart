import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_colors.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';
import 'package:unimanga_app/app/modules/home/views/home_views.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.result});

  final String result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        alignment: Alignment.center,
        color: AppColors.lightWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: widget.result == "00" ? const Text("Thanh toán thành công!") : Text("Thanh toán thất bại"),
            ),
            GestureDetector(
              onTap: () => Get.offAll(HomeView()),
              child: Container( 
                 margin: EdgeInsets.only(top: 30),         
                 alignment: Alignment.center,
                  height: 50,
                  width: 200, 
                  decoration: BoxDecoration(
                    color: AppColors.RedPrimary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextCustom(text: "Về trang chủ",color: AppColors.lightWhite, fontsize: 15, fontWeight: FontWeight.bold,), 
              ),
            )
          ],
        ),
      )
    );
  }
}