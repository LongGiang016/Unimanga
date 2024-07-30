// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:intern_vua_gao/app/global_widgets/text_custom.dart';
// import '../constants/index.dart';

// double sizefix( double size , double screen){
//    return Sizefix.sizefix(size, screen);
// }

// class CountDownSale extends GetView {
//   final h;
//   final m;
//   final s;
//   final screenWidth;
//   final screenHeight;
//   CountDownSale({required this.h, required this.m, required this.s,  required  this.screenWidth, required this.screenHeight});
//     @override
//     Widget build(BuildContext context){
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(
//                   bottom: sizefix(20.0,screenWidth), 
//                   top: sizefix(20.0, screenWidth), 
//                 ),
//                 alignment: Alignment.centerLeft,
//                 child: TextCustom(
//                   text: "SALE!!!!",
//                   fontsize: sizefix(16, screenWidth), 
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.red,
//                 ),
//               ),
//               SizedBox(width: sizefix(10, screenWidth), ),
//               Container(
//                 height: sizefix(20, screenHeight), 
//                 width: sizefix(30, screenWidth), 
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(sizefix(4, screenWidth), ),
//                 ),
//                 child: Text(
//                   h.toString(),
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Container(
//                 child: Text(":"), 
//                 margin: EdgeInsets.only(right: sizefix(5, screenWidth),  left: sizefix(5, screenWidth), ),
//               ),
//               Container(
//                 height: 20,
//                 width: 30,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   s.toString(),
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Container(
//                 child: Text(":"), 
//                 margin: EdgeInsets.only(right: sizefix(5, screenWidth), left: sizefix(5, screenWidth)),
//               ),
//               Container(
//                 height: sizefix(20,screenHeight),
//                 width: sizefix(30, screenWidth),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(sizefix(4, screenWidth),),
//                 ),
//                 child: Text(
//                   s.toString(),
//                   style: TextStyle(color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
             
//             ],
//           ),
  
//         ],
//       );
//     }
//   }
