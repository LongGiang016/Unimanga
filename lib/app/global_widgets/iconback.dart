import 'package:flutter/material.dart';
import 'package:get/get.dart';



class IconBack extends StatelessWidget{
  final color;
  
  IconBack({this.color});
  Widget build (BuildContext context){
    return Container(
      child:  IconButton(
        icon: Icon(
          Icons.arrow_back,
            color: color,
        ),
        onPressed:(){
          Get.back();
        }
      ),
    );
  }
}

class IconBack2 extends StatelessWidget{
  final color;
  IconBack2({this.color});
  Widget build (BuildContext context){
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Icon(Icons.arrow_back, color: color,)
    );
  }
}