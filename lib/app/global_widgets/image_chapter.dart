import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/index.dart';
import '../models/chap_comic.dart';
double sizefix( double size , double screen){
   return Sizefix.sizefix(size, screen);
}
class ImageChapItem extends GetView{
 const ImageChapItem({super.key, required this.imageChap, required this.screenHeight, required this.screenWidth});
 final ImageChap imageChap;
 final screenWidth ;
 final screenHeight;
 @override
Widget build (BuildContext context){
  String imageUrl = imageChap.url ?? ''; 
  bool isValidUrl = Uri.tryParse(imageUrl)?.hasAbsolutePath ?? false; 
  return Container(
    child: isValidUrl
      ? Image.network(imageUrl, fit:  BoxFit.fitHeight) 
      : const Center(child: Text("Hình ảnh không khả dụng")), 
  );
}

}