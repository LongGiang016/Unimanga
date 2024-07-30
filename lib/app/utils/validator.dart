// import 'dart:ui';

// import 'package:flutter/cupertino.dart' as ui;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Validator {
//   Validator();

//   String? email(String? value, String message, String messageEmpty) {
//     if (value!.isEmpty) {
//       return messageEmpty;
//     }
//     String pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return message;
//     else
//       return null;
//   }

//   String? tel(String? value, Map<String, dynamic> message) {
//     if (value!.isEmpty) {
//       return message['EMPTY_TEL'];
//     }

//     if (value.length > 16 || value.length < 9) return message['VALID_TEL'];

//     String pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
//     RegExp regex = RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return message['VALID_TEL'];
//     else
//       return null;
//   }

//   String? empty(String? value, String? message) {
//     if (value == null || value.isEmpty) {
//       return message;
//     }
//     return null;
//   }

//   String? money(String? value, String? message) {
//     double flag = double.parse(value!.replaceAll(",", ""));
//     if (flag == 0) {
//       return message;
//     }
//     return null;
//   }

//   String? validPassword(String? value, [String? message]) {
//     if (value!.isEmpty) {
//       return message;
//     }

//     String pattern =
//         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
//     RegExp regex = RegExp(pattern);
//     if (!regex.hasMatch(value))
//       return message;
//     else
//       return null;
//   }

//   String? cPassword(
//       String? value, String password, Map<String, dynamic> message) {
//     if (value!.isEmpty) {
//       return message['EMPTY_CPASSWORD'];
//     }

//     if (password.isEmpty) {
//       return message['EMPTY_PASSWORD'];
//     }
//     if (value != password) {
//       return message['VALID_C_PASSWORD'];
//     }
//     return null;
//   }

//   String? validateRequireAllField(Map<String, dynamic> obj, String message) {
//     bool isValid = true;
//     obj.forEach((key, value) {
//       if (value == "" ||
//           value == null ||
//           value.trim() == "" ||
//           value.trim() == null) {
//         isValid = false;
//       }
//     });
//     if (isValid) {
//       return null;
//     } else {
//       return message;
//     }
//   }

//   String? validateForm(List<String?> validateGroup) {
//     var length = validateGroup.length;
//     for (var i = 0; i < length; i++) {
//       String? message = validateGroup[i];
//       if (message != null) {
//         return message;
//       } else {
//         if (i == length - 1) {
//           return "";
//         } else {}
//       }
//     }
//   }

//   List textConvertArray(String text) {
//     String convertKhoangCach = text.replaceAll(" ", "(/sNha) ");
//     String convertXuongDong = convertKhoangCach.replaceAll('\n', "(/nNha)\n");
//     List arrayText = convertXuongDong.split(new RegExp(r'[\s\n]+'));

//     return arrayText;
//   }

//   int getNumberOfLines(String text) {
//     if (text.isEmpty) return 0;

//     final span = TextSpan(
//         text: text,
//         style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14));
//     final tp = TextPainter(text: span, textDirection: ui.TextDirection.ltr);
//     tp.layout(maxWidth: Get.size.width - 45);
//     return tp.computeLineMetrics().length;
//   }
// }
