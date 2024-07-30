// import 'package:intern_vua_gao/app/core/base_response.dart';
// import 'package:intern_vua_gao/app/models/categoryproduct_model.dart';
// import 'package:intern_vua_gao/app/models/product_model.dart';
// import 'package:intern_vua_gao/app/modules/dashboard/provider/dashboard_provider.dart';
// import 'package:intern_vua_gao/app/modules/home/models/home_model.dart';

// class DashboardRepository {
//   DashboardRepository({required this.dashboardProvider});
//   final DashboardProvider dashboardProvider;
//   Future<BaseResponse?>getProductSales(ProductModel product) =>
//       dashboardProvider.getProductsSale(product);
//   Future<BaseResponse?>getProductsHomes(ProductModel product) =>
//       dashboardProvider.getProductsHomes(product);
//   Future<BaseResponse?> loadDataBase(CategoryProductModel cate) =>
//   dashboardProvider.getCategoryProduct(cate);
      
// }
import 'package:unimanga_app/app/modules/category/provider/dashboard_provider.dart';

import '../../../models/category_comic_model.dart';

class CategoryReponsitory{
  CategoryReponsitory({required this.categoryReponsitory});
  final CategoryProvider categoryReponsitory;

  Future<List<categoryComicModel>> getCategoryList() =>
    categoryReponsitory.getDanhSachTheLoai();
}
