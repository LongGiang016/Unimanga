import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/models/user.dart';

import '../../../../constants/app_function.dart';
import '../../../../global_widgets/appbar_custom.dart';
import '../../../../global_widgets/tag_custom.dart';
import '../../../category/bindings/category_binding.dart';
import '../../../dashboard/bindings/dashboard_bindings.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';
import '../../../infor_user/repository/user_repository.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

// Giao diện Danh sách Manga
class ListUserView extends GetView {
  const ListUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: ListUser(),
        ),
      ],
    );
  }
}

//  Hiển thị truyện khi có dữ liệu và ngược lại
class ListUser extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    return Obx(() {
      var listUser = controller.listuser;
      if (listUser.isEmpty) {
        return Center(
          child: Text('Chưa có người dùng nào'),
        );
      }
      List<Users> topUsers = listUser;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < topUsers.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: ListUsersItems(topUsers[i], i),
            )
        ],
      );
    });
  }
}

Widget ListUsersItems(Users user, int index) {
  // final double screenHeight = MediaQuery.of(context).size.height;
  return Container(
    child: Card(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${index + 4}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8.0),
            CircleAvatar(
              child: ClipOval(
                child: Image(
                  image: NetworkImage("${user.imageUrl}" ?? " "),
                  fit: BoxFit.cover,
                  width: 60.0,
                  height: 60.0,
                ),
              ),
              radius: 30.0,
            ),
          ],
        ),
        title: Text(
          "${user.name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: TagWidgetItems(score: user.score!),
      ),
    ),
  );
}


// class ListUsersItems extends GetView<DashboardController> {
//   const ListUsersItems({super.key, required this.user});
//   final Users user;
//   @override
//   Widget build(BuildContext context) {
//     // final double screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       child: Card(
//         child: ListTile(
//           leading: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '4.',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               CircleAvatar(
//                 child: ClipOval(
//                   child: Image(
//                     image: NetworkImage("${user.imageUrl}" ?? " "),
//                     fit: BoxFit.cover,
//                     width: 60.0,
//                     height: 60.0,
//                   ),
//                 ),
//                 radius: 30.0,
//               ),
//             ],
//           ),
//           title: Text(
//             "${user.name}",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16.0,
//             ),
//           ),
//           subtitle: TagWidget(),
//         ),
//       ),
//     );
//   }
// }
