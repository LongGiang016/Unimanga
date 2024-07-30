// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unimanga_app/app/models/comic_model.dart';
// import '../../../constants/app_colors.dart';
// import '../../../constants/app_function.dart';
// import '../../category/bindings/category_binding.dart';
// import '../../comic_detail/views/comic_detail.dart';
// import '../../dashboard/bindings/dashboard_bindings.dart';
// import '../../dashboard/controllers/dashboard_controllers.dart';

// double sizefix(double size, double screen) {
//   return Sizefix.sizefix(size, screen);
// }

// // Giao diện Danh sách Manga
// class ListComicView extends GetView {
//   const ListComicView(
//       {super.key, required this.screenHeight, required this.screenWidth});
//   final double screenWidth;
//   final double screenHeight;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SingleChildScrollView(
//           child: ListComic(),
//         ),
//       ],
//     );
//   }
// }

// //  Hiển thị truyện khi có dữ liệu và ngược lại
// class ListComic extends GetView<DashboardController> {
//   @override
//   Widget build(BuildContext context) {
//     DashBoardBindings().dependencies();
//     return Obx(() {
//       var listComic = controller.listcomic;
//       if (listComic.isEmpty) {
//         return Center(
//           child: Text('Chưa có truyện nào'),
//         );
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           for (int i = 0; i < listComic.length; i++)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 0),
//               child: ListItems(comic: listComic[i]),
//             )
//         ],
//       );
//     });
//   }
// }

// // Item Manga
// class ListItems extends GetView<DashboardController> {
//   const ListItems({super.key, required this.comic});
//   final ComicModel comic;
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return GestureDetector(
//       onTap: () async {
//         DashBoardBindings().dependencies();
//         await controller.fecchComic(comic.id!);
//         Get.to(() => ComicDetail(comic: comic));
//       },
//       child: Container(
//         child: Card(
//           color: Color.fromARGB(255, 238, 236, 236),
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: InkWell(
//                     onTap: () {},
//                     child: Container(
//                       height: sizefix(160, screenHeight),
//                       decoration: BoxDecoration(
//                         color: AppColors.black,
//                         image: DecorationImage(
//                           image: NetworkImage(comic.anhTruyen!),
//                           fit: BoxFit.cover,
//                           alignment: Alignment.center,
//                         ),
//                       ),
//                     )),
//               ),
//               SizedBox(width: 10.0),
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 100),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         comic.ten!.length >= 16
//                             ? "${comic.ten!.substring(0, 16)}..."
//                             : comic.ten!,
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Text("Chapter: ${comic.soChuong}"),
//                       Text("Cập nhật lúc: ${comic.tinhTrang}"),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
