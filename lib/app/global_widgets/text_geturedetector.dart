import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:unimanga_app/app/global_widgets/index.dart';

class TextGetureDetectortoNamed extends StatelessWidget{
  final TextCustom textcustom;
  final  routes_string ;
  TextGetureDetectortoNamed({required this.textcustom,  required this.routes_string });
  Widget build(BuildContext context){
    return
    GestureDetector(
      onTap: (){
        Get.toNamed(routes_string );

      },
      child:Container(
        child:  textcustom
      ),  
    );    
  }
}


class TextGetureDetectoroffNamed extends StatelessWidget{
  final TextCustom textcustom;
  final  routes_string ;
  TextGetureDetectoroffNamed({required this.textcustom,  required this.routes_string });
  Widget build(BuildContext context){
    return
    GestureDetector(
      onTap: (){
        Get.offNamed(routes_string  );

      },
      child:Container(
        child:  textcustom
      ),  
    );    
  }
}