
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
// import 'package:intern_vua_gao/app/models/categoryproduct_model.dart';
// import 'package:intern_vua_gao/app/models/product_model.dart';
// import 'package:intern_vua_gao/app/services/global_service.dart';
// import 'package:intern_vua_gao/app/services/http_provider.dart';

// import '../../../core/base_response.dart';
// class DashboardProvider extends GetConnect {
//   DashboardProvider({required this.http});
//   final HttpProvider http;
//    Map<String, dynamic> _defaultBody = {
//     'app_key': dotenv.env['APPKEY'],
//     'op': dotenv.env['OPTION'],
//     'ver': dotenv.env['VER'],
//   };
// Future<BaseResponse?> getCategoryProduct(CategoryProductModel categoryProductModel) async {
//     Map<String, dynamic> submit = Map<String, dynamic>(
//     );
//     submit.addAll(_defaultBody);
//     submit.addAll(categoryProductModel.toMap());
//     try {
//     var response = await http.doPost("", submit);
//     return BaseResponse(
//         statusCode: response.statusCode,
//         statusText: response.statusMessage,
//         status: response.data['error'],
//         data: response.data['data']['arrayCategoryProducts'] ?? {},
//         message:
//             response.data['message'] != null ? response.data['message'] : ""
//         );
//   } catch (e) {
//     return BaseResponse(statusText: e.toString(), statusCode: 400);
//   }
//   }
//   Future<BaseResponse?> getProductsSale(ProductModel product) async {
//     Map<String, dynamic> submit = Map<String, dynamic>(
//     );
//     submit.addAll(_defaultBody);
//     submit.addAll(product.toMap());
//     try {
//     var response = await http.doPost("", submit);
//     return BaseResponse(
//         statusCode: response.statusCode,
//         statusText: response.statusMessage,
//         status: response.data['error'],
//         data: response.data['data']['arrayProductsSale'] ?? {},
//         message:
//             response.data['message'] != null ? response.data['message'] : ""
//         );
//   } catch (e) {
//     return BaseResponse(statusText: e.toString(), statusCode: 400);
//   }
//   }

//   Future<BaseResponse?> getProductsHomes(ProductModel product) async {
//     Map<String, dynamic> submit = Map<String, dynamic>(
//     );
//     submit.addAll(_defaultBody);
//     submit.addAll(product.toMap());
//     try {
//     var response = await http.doPost("", submit);
//     return BaseResponse(
//         statusCode: response.statusCode,
//         statusText: response.statusMessage,
//         status: response.data['error'],
//         data: response.data['data']['arrayProductsHome'] ?? {},
//         message:
//             response.data['message'] != null ? response.data['message'] : ""
//         );
//   } catch (e) {
//     return BaseResponse(statusText: e.toString(), statusCode: 400);
//   }
//   }

// // Future<List<ProductModel>?> getProductsSale() async {
// //   Map<String, dynamic> requestData = Map<String, dynamic>();
// //   requestData.addAll(_defaultBody);
// //   try {
// //   var response = await http.doPost('', requestData);
// //   print('Phản hồi từ máy chủ: ${response.data['data']['arrayCategoryProducts']}');
// //   if (response.statusCode == 200) {
// //     var data = response.data['data']['arrayProductsSale'] as List;
// //     List<ProductModel> ProductsSales = data.map((item) => ProductModel.fromJson(item)).toList();
// //     print(ProductsSales);
// //     return ProductsSales;
// //   } else {
// //     return null;
// //   }
  
// // } catch (e) {
// //   print('Lỗi: $e');
// // }

// // }

// // Future<List<ProductModel>?> getProductsAll() async {
// //   Map<String, dynamic> requestData = Map<String, dynamic>();
// //   requestData.addAll(_defaultBody);
// //   try {
// //   var response = await http.doPost('', requestData);
// //   print('Phản hồi từ máy chủ: ${response.data['data']['arrayProductsHome']}');
// //   if (response.statusCode == 200) {
// //     var data = response.data['data']['arrayProductsHome'] as List;
// //     List<ProductModel> ProductsSales = data.map((item) => ProductModel.fromJson(item)).toList();
// //     print(ProductsSales);
// //     return ProductsSales;
// //   } else {
// //     return null;
// //   }
  
// // } catch (e) {
// //   print('Lỗi: $e');
// // }

// // }

  
// }