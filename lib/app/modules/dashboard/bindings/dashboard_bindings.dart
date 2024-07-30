import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import 'package:unimanga_app/app/modules/dashboard/provider/dashboard_provider.dart';
import 'package:unimanga_app/app/modules/dashboard/repository/dashboard_repository.dart';
import '../../category/repository/category_repository.dart';


class DashBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardProvider());
    Get.lazyPut(() => DashboardReponsitory(dashboardProvider: Get.find<DashboardProvider>()));
    Get.put(DashboardController(dashboardReponsitory: Get.find<DashboardReponsitory>()));
  }
}
