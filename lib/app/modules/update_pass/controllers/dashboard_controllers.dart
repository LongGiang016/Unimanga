// import 'package:get/get.dart';
// import 'package:intern_vua_gao/app/core/cache_manager.dart';
// import 'package:intern_vua_gao/app/models/categoryproduct_model.dart';
// import 'package:intern_vua_gao/app/models/product_model.dart';
// import 'package:intern_vua_gao/app/modules/dashboard/repository/dashboard_repository.dart';
// import 'package:intern_vua_gao/app/services/global_service.dart';

// import '../../../services/domain_service.dart';


// class DashboardController extends GetxController with CacheManager {
//   final DashboardRepository dashboardRepository;
//   final globalController = Get.find<GlobalService>();
//   DashboardController({required this.dashboardRepository});
//   var listCate = <CategoryProductModel>[].obs;
//   var listProductSale = <ProductModel>[].obs;
//   var listProdctAll = <ProductModel>[].obs;
//   var cachedData;
//   @override
//   void onInit() async {
//     super.onInit();
//     await cacheRemove(CacheManagerKey.PRODUCT_DETAIL);
//     print("${await cacheGet(CacheManagerKey.PRODUCT_DETAIL)}");
//     print("ID cua nguoi dung ${globalController.userId.value}");
//     fetchCategoryProduct();
//     fetchProductsSale();
//     fetchProductsHome();
    
//   }
//   Future<void> fetchCategoryProduct() async {
//    var cachedData = await cacheGet(CacheManagerKey.LIST_CATEGORY_PRODUCT);
//     if( cachedData == null){
//        var response = await dashboardRepository.loadDataBase(CategoryProductModel(act: DomainProvider.HOME, userId:globalController.userId.value));
//       if (response?.data != null) {
//         List<dynamic> data = response?.data;
//         listCate.value = data.map((item) => CategoryProductModel.fromJson(item)).toList();
//         await cacheSave(CacheManagerKey.LIST_CATEGORY_PRODUCT, response?.data);  
//       }
//     }else{
//       List<dynamic> data = cachedData as List<dynamic>;
//       listCate.value = data.map((item) => CategoryProductModel.fromJson(item)).toList();
//     }
//   }
  

//   Future<void> fetchProductsSale() async{
//     var cachedData = await cacheGet(CacheManagerKey.LIST_PRODUCT_SALE);
//     if(cachedData == null){
//     var response = await dashboardRepository.getProductSales(ProductModel(act: DomainProvider.HOME, userId:globalController.userId.value));
//     if (response?.data != null) {
//       List<dynamic> data = response?.data;
//       listProductSale.value = data.map((item) => ProductModel.fromJson(item)).toList();
//       await cacheSave(CacheManagerKey.LIST_PRODUCT_SALE, response?.data); 
//     }
//     }else{
//        List<dynamic> data = cachedData as List<dynamic>;
//        listProductSale.value = data.map((item) => ProductModel.fromJson(item)).toList();
//     }
//   }
//   Future<void> fetchProductsHome() async{
//     var cachedData = await cacheGet(CacheManagerKey.LIST_PRODUCT_HOME);
//     if(cachedData == null){
//     var response = await dashboardRepository.getProductsHomes(ProductModel(act: DomainProvider.HOME, userId:globalController.userId.value));
//     if (response?.data != null) {
//       List<dynamic> data = response?.data;
//       listProdctAll.value = data.map((item) => ProductModel.fromJson(item)).toList();
//       await cacheSave(CacheManagerKey.LIST_PRODUCT_HOME, response?.data); 
//     }
//     }else{
//       List<dynamic> data = cachedData as List<dynamic>;
//       listProdctAll.value = data.map((item) => ProductModel.fromJson(item)).toList();
//     }
//   }

// }

