import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class AppbarCustoms extends StatelessWidget implements PreferredSizeWidget {
  AppbarCustoms(
      {Key? key,
      this.isBack = true,
      this.listWidgetAction,
      required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize;
  final bool isBack;
  final String title;
  final List<Widget>? listWidgetAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightWhite,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.greenPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.greenPrimary,
        ),
        onPressed: () => Get.back(),
      ),
      actions: listWidgetAction,
    );
  }
}
