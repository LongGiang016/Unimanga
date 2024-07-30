// ignore: camel_case_types
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';

import '../../../../constants/app_function.dart';
import '../../../../constants/index.dart';
import '../../../../models/comic_model.dart';
double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}

class carouseu extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const carouseu({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();

    return Obx(() => CarouselSlider(
      items: controller.listcomic.map((comic) {
        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(sizefix(5, screenWidth)),
            child: Image.network(comic.anhBiaTruyen!, fit: BoxFit.cover),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: sizefix(177, screenHeight),
        aspectRatio: 16 / 9,
        viewportFraction: 1.0,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: null,
        scrollDirection: Axis.horizontal,
      ),
    ));
  }
}
