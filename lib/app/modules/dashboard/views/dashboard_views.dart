import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimanga_app/app/global_widgets/comic_items.dart';
import 'package:unimanga_app/app/models/category_comic_model.dart';
import 'package:unimanga_app/app/modules/category/bindings/category_binding.dart';
import 'package:unimanga_app/app/modules/dashboard/bindings/dashboard_bindings.dart';
import 'package:unimanga_app/app/modules/dashboard/controllers/dashboard_controllers.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_comic_action.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_comic_adventure.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_comic_fantasy.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_comic_hot.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_comic_isekai.dart';
import 'package:unimanga_app/app/modules/dashboard/views/Dashboard_child/list_newupdate_comic..dart';
import 'package:unimanga_app/app/modules/filter_comic/bindings/filter_comic_bindings.dart';
import 'package:unimanga_app/app/modules/filter_comic/views/fillter_comic_views.dart';
import 'package:unimanga_app/app/modules/infor_user/bindings/info_user_bindings.dart';
import 'package:unimanga_app/app/modules/infor_user/views/profile_screen.dart';
import 'package:unimanga_app/app/modules/list_ranking/views/list_ranking.dart';
import 'package:unimanga_app/app/modules/payment/bindings/payment_binding.dart';
import '../../../constants/index.dart';
import '../../../global_widgets/index.dart';
import '../../infor_user/controller/user_controller.dart';
import '../../payment/mainpayment.dart';
import '../../seach_comic/views/seach_view.dart';
import '../../signin/views/SignIn.dart';
import 'Dashboard_child/carouseu.dart';

double sizefix(double size, double screen) {
  return Sizefix.sizefix(size, screen);
}

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    DashBoardBindings().dependencies();
    InforUserbinding().dependencies();
    FilterComicbinding().dependencies();
    CategoryBinding().dependencies();
    final inforUserController = Get.find<InforUserController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
      onRefresh: () async{
        await controller.fetchComicList();
        await controller.fetchComicListNewUpdate();
      },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: sizefix(130, screenHeight),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.HomeBackGround1,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Obx(() {
                    final user = inforUserController.user.value;
                    return SizedBox(
                      height: sizefix(80, screenHeight),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 90,
                              child: Image.asset(
                                AppImages.Logoapp,
                                fit: BoxFit.cover,
                              ),
                            ),
                            user == null
                                ? SizedBox(
                                    width: 220,
                                    height: sizefix(60, screenHeight),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.RedPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 20,
                                            width: 65,
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.to(const Login_Screen());
                                                },
                                                child: TextCustom(
                                                  text: "Đăng nhập",
                                                  fontsize: 9,
                                                  color: AppColors.lightWhite,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.RedPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 20,
                                            width: 65,
                                            child: TextCustom(
                                              text: "Đăng ký",
                                              fontsize: 9,
                                              color: AppColors.lightWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () => Get.to(SearchView()),
                                              child: Icon(
                                                Icons.search,
                                                color: AppColors.RedPrimary,
                                              )),
                                          Icon(
                                            Icons.notifications,
                                            color: AppColors.RedPrimary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: sizefix(190, screenWidth),
                                    height: sizefix(60, screenHeight),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 7),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Get.to(ProfileScreen()),
                                            child: ClipOval(
                                              child: Image.network(
                                                user.imageUrl ??
                                                    'https://firebasestorage.googleapis.com/v0/b/unimanga-37d5f.appspot.com/o/Users%2Flogo.jpg?alt=media&token=d2aa5b5e-ed06-4b0f-9c57-fcebe2699088',
                                                height: sizefix(32, screenHeight),
                                                width: sizefix(32, screenWidth),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                              onTap: () => Get.to(SearchView()),
                                              child: Icon(
                                                Icons.search,
                                                color: AppColors.RedPrimary,
                                              )),
                                          Icon(
                                            Icons.notifications,
                                            color: AppColors.RedPrimary,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Container(
                color: AppColors.lightWhite,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: sizefix(10, screenWidth),
                      right: sizefix(10, screenWidth)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      carouseu(
                          screenWidth: screenWidth, screenHeight: screenHeight),
                      SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(const FilterComicView()),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: sizefix(35, screenHeight),
                                  width: sizefix(35, screenHeight),
                                  child: Image.asset(AppImages.icLogorankbook),
                                ),
                                TextCustom(
                                  text: "Thể loại",
                                  color: AppColors.blackPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontsize: sizefix(10, screenWidth),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(ListRanking()),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: sizefix(35, screenHeight),
                                  width: sizefix(35, screenHeight),
                                  child: Image.asset(AppImages.icLogorankuser),
                                ),
                                TextCustom(
                                  text: "Top User",
                                  color: AppColors.blackPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontsize: sizefix(10, screenWidth),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(FilterComicView()),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: sizefix(35, screenHeight),
                                  width: sizefix(35, screenHeight),
                                  child: Image.asset(AppImages.icLogonewbook1),
                                ),
                                TextCustom(
                                  text: "Mới nhất",
                                  color: AppColors.blackPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontsize: sizefix(10, screenWidth),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizefix(20, screenHeight),
                      ),
                      //Truyện đề cử
                      ListComicHotView(
                          screenHeight: screenHeight, screenWidth: screenWidth),
        
                      SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      ListComicNewUpdate(screenHeight: screenHeight, screenWidth: screenWidth),
                       
                       SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      //Truyện action
                      ListComicActionView(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      //Truyện action
                      ListComicIsekai(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      //Truyện action
                      ListComicAdventure(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                          SizedBox(
                        height: sizefix(15, screenHeight),
                      ),
                      //Truyện action
                      ListComicFantasy(
                          screenHeight: screenHeight, screenWidth: screenWidth),
                      const SizedBox(height: 50),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestGetAnh extends StatefulWidget {
  const TestGetAnh({super.key});

  @override
  State<TestGetAnh> createState() => _TestGetAnhState();
}

class _TestGetAnhState extends State<TestGetAnh> {
  @override
  Widget build(BuildContext context) {
    File? _image;
    final picker = ImagePicker();
    final database = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://unimanga-37d5f-default-rtdb.asia-southeast1.firebasedatabase.app/');
    final Future<FirebaseApp> initialization = Firebase.initializeApp();
    Future getImage() async {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
        } else {
          print("Khong co ảnh được chọn");
        }
      });
    }

    Future<List<categoryComicModel>> getDanhSachTheLoai() async {
      try {
        DatabaseReference invoiceRef =
            stringFirebase.databaseconnect.ref('UniManga');
        DataSnapshot snapshot =
            (await invoiceRef.child('TheLoai').once()).snapshot;

        List<categoryComicModel> invoices = [];
        List<dynamic> values = snapshot.value as List<dynamic>;
        values.forEach((element) {
          invoices.add(
              categoryComicModel.fromJson(element as Map<String, dynamic>));
        });
        print(invoices);
        return invoices;
      } catch (e) {
        print('Error loading invoices: $e');
        return [];
      }
    }

    return Scaffold(
        body: Column(
      children: [
        Center(
          child: _image == null
              ? Text("Không có ảnh được chọn")
              : Image.file(_image!),
        ),
        Center(
          child: ElevatedButton(
            onPressed: getImage,
            child: Text('Chọn ảnh'),
          ),
        ),
      ],
    ));
  }
}
