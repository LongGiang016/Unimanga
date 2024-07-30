import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/models/user.dart';
import 'package:unimanga_app/app/modules/home/views/home_views.dart';
import 'package:unimanga_app/app/modules/signup/provider/signup_provider.dart';
import 'package:unimanga_app/app/modules/signup/views/SignUp.dart';
import '../../signin/repository/signin_repository.dart';


class SignupRepository extends GetxController {
  static SignupRepository get instance => Get.find();
  // SignupRepository({required this.signupReponsitory});
  // final SignupProvider signupReponsitory;
    final authRepo = Get.put(SignupProvider());
   Future<void> createUser(Users user) async {
    await authRepo.createUser(user);
  }

}

// class SignupRepository extends GetxController {
//   static Auth_Resposity get instance => Get.find();

//   final _auth = FirebaseAuth.instance;

//   late Rx<User?> firebaseUser = Rx<User?>(null);
//   var verificationId = ''.obs;

//   @override
//   void onReady() {
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     ever(firebaseUser, _setInitialScreen);
//   }

//   _setInitialScreen(User? user) {
//     user == null
//         ? Get.offAll(() => const HomeView())
//         : Get.offAll(() => const SignUp());
//   }

//   loginAccount(Users user) async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: user.email,
//         password: user.password.toString(),
//       );
//     } on FirebaseAuthException catch (e) {
//       final ex = SignUp_AccountFailure.code(e.code);
//       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
//       throw SignUp_AccountFailure(ex.message);
//     } catch (_) {}
//   }
// }
