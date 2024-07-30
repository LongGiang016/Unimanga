import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_images.dart';
import 'package:unimanga_app/app/models/user.dart';

import '../../../../constants/app_function.dart';
import '../../../../global_widgets/appbar_custom.dart';
import '../../../../global_widgets/tag_custom.dart';
import '../../../dashboard/bindings/dashboard_bindings.dart';
import '../../../dashboard/controllers/dashboard_controllers.dart';



// Giao diện Danh sách Manga
class ListUserTopView extends GetView {
  const ListUserTopView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(fit: StackFit.loose, clipBehavior: Clip.none, children: [
          RankingWidget(),
          ListUserTop(),
        ])
      ],
    );
  }
}

//  Hiển thị truyện khi có dữ liệu và ngược lại
class ListUserTop extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    
    return Obx(() {
      var list = controller.listtop;

      if (list.isEmpty) {
        return Center(child: RankingWidget());
      }

      // Lấy ra 3 người dùng có điểm số cao nhất
      List<Users> topThreeUsers = list.take(3).toList();

      return Row(
        children: [
          // Gán thông tin của Top 2
          Padding(
            padding: EdgeInsets.only(top: 70, left: 1),
            child: _buildUserWidget(topThreeUsers[1], 2),
          ),
          // Gán thông tin của Top 1
          Padding(
            padding: EdgeInsets.only(top: 70, left: 1),
            child: _buildUserWidget(topThreeUsers[0], 1),
          ),
          // Gán thông tin của Top 3
          Padding(
            padding: EdgeInsets.only(top: 80, left: 1),
            child: _buildUserWidget(topThreeUsers[2], 3),
          ),
        ],
      );
    });
  }
}

Widget _buildUserWidget(Users userData, int rank) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.transparent,
    ),
    child: Column(
      children: [
        CircleAvatar(
          child: ClipOval(
            child: Image(
              image:
                  NetworkImage(userData.imageUrl ?? '${AppImages.bgProfile}'),
              fit: BoxFit.cover,
              width: 60.0,
              height: 60.0,
            ),
          ),
          radius: rank == 1 ? 30.0 : (rank == 2 ? 20.0 : 15.0),
        ),
        SizedBox(height: 5),
        Text(
          "${userData.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        TagWidgetItems(score: userData.score!),
      ],
    ),
  );
}
