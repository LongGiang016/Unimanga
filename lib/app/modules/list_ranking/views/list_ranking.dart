import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/list_ranking/views/component/list_morethree.dart';
import 'package:unimanga_app/app/modules/list_ranking/views/component/list_topthree.dart';
import '../../dashboard/bindings/dashboard_bindings.dart';
import '../../dashboard/controllers/dashboard_controllers.dart';
import '../../infor_user/bindings/info_user_bindings.dart';
import '../../infor_user/controller/user_controller.dart';

class ListRanking extends StatefulWidget {
  const ListRanking({super.key});

  @override
  State<ListRanking> createState() => _ListRankingState();
}

class _ListRankingState extends State<ListRanking> {
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    InforUserbinding().dependencies();
    final dashboardController = Get.find<DashboardController>();

    Future<void> _refresh() async {
      await dashboardController.fetchListTopUser();
      await dashboardController.fetchTopUser();
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Bảng xếp hạng",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListUserTopView(),
              ListUserView(),
            ],
          ),
        ),
      ),
    );
  }
}
