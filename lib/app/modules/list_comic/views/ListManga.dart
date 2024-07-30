// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:unimanga_app/app/models/comic_model.dart';

// import '../../../constants/app_colors.dart';
// import '../../../constants/app_function.dart';
// import '../../../global_widgets/Filter.dart';
// import '../../../global_widgets/comic_items.dart';
// import '../../../global_widgets/item_manga.dart';
// import '../../../global_widgets/text_custom.dart';
// import '../../../models/chap_comic.dart';
// import '../../category/bindings/category_binding.dart';
// import '../../dashboard/controllers/dashboard_controllers.dart';
// import 'list_filter.dart';
// import 'list_manga_dashboard.dart';



// class ListManga extends GetView<DashboardController> {
//   @override
//   Widget build(BuildContext context) {
//     DashBoardBinding().dependencies();
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "Danh sách truyện tranh",
//           style: TextStyle(fontWeight: FontWeight.w800),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 5),
//             child: Row(
//               children: [
//                 const Expanded(
//                     child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Thể loại: '),
//                     Text('Trạng thái: '),
//                   ],
//                 )),
//                 IconButton(
//                     onPressed: () {
//                       showFilterBottomSheet(context);
//                     },
//                     icon: Icon(Icons.filter_list))
//               ],
//             ),
//           ),
//           Expanded(
//               child: SingleChildScrollView(
//             child: ListComicView(
//                 screenHeight: screenHeight, screenWidth: screenWidth),
//           )),
//         ],
//       ),
//     );
//   }
// }
// // Hàm gọi BottomSheet
// void showFilterBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(16.0),
//       ),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: Filter(),
//       );
//     },
//   );
// }
