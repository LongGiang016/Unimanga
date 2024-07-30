// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:unimanga_app/app/modules/dashboard/views/dashboard_views.dart';
// import 'package:unimanga_app/app/modules/infor_user/repository/info_user_repository.dart';

// import '../../../models/user.dart';
// import '../../home/views/home_views.dart';

// class InforUserController extends GetxController {
//   InforUserController({required this.inforUserRepository});

//   final InforUserRepository inforUserRepository;

//   var user = Rxn<Users>();

//   User? firebaseUser = FirebaseAuth.instance.currentUser;

//   @override
//   void onInit() {
//     super.onInit();
//     if (firebaseUser != null) {
//       fetchUser(firebaseUser!.uid);
//     } else {
//       print('Không có tài khoản.');
//     }
//   }

//   Future<void> fetchUser(String uid) async {
//     try {
//       Users? fetchedUser = await inforUserRepository.getUserByUid(uid);
//       if (fetchedUser != null) {
//         user.value = fetchedUser;
//       } else {
//         print('Không tìm thấy');
//       }
//     } catch (e) {
//       print('Error fetching user information: $e');
//     }
//   }










  
//   void logout() {
//     FirebaseAuth.instance.signOut().then((_) {
//       user.value = null;
//       Get.offAll(() => DashboardView());  
//       Get.offAll(() => HomeView());
//     }).catchError((error) {
//       print("Đăng xuất không thành công: $error");
//     });
//   }
  

// }