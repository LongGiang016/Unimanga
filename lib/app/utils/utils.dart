// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Utils {
//   static Future<void> setFcmId(String fcmId) async {
//     var pref = await SharedPreferences.getInstance();
//     await pref.setString(fcmId, fcmId);
//   }

//   static Future<String?> getFcmId(String fcmId) async {
//     return (await SharedPreferences.getInstance()).getString(fcmId) ?? null;
//   }

//   static getFileNameFromFilePath(String filePath) {
//     final pathArr = filePath.split("/");
//     return pathArr[pathArr.length - 1];
//   }

//   static changeLanguage(BuildContext context, lang) async {
//     var currentLang = FlutterI18n.currentLocale(context);
//     currentLang = Locale(lang);
//     await FlutterI18n.refresh(context, currentLang);
//   }

//   static removeVietnameseSpecialCharacter(String value) {
//     String str = value.toLowerCase();
//     str = str
//         .replaceAll(RegExp(r"/|á|à|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|/$"), 'a')
//         .replaceAll(RegExp(r"/|è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ|/$"), "e")
//         .replaceAll(RegExp(r"/|ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|/$"), "o")
//         .replaceAll(RegExp(r"/|ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ|/$"), "u")
//         .replaceAll(RegExp(r"/|ỳ|ý|ỵ|ỷ|ỹ|/$"), "y")
//         .replaceAll(RegExp(r"/|ì|í|ị|ỉ|ĩ|/$"), "i")
//         .replaceAll(RegExp(r"/|đ|/$"), "d");
//     return str;
//   }
// }
