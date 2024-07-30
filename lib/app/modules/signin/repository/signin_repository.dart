import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:unimanga_app/app/models/user.dart';
import '../../signup/provider/signup_failer.dart';

class SigninRepository extends GetxController {
  final _auth = FirebaseAuth.instance;
  Future<void> loginAccount(Users user) async {
    try {
      // Đăng nhập người dùng
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(),
        password: user.password.toString(),
      );

      // Lấy thông tin người dùng hiện tại
      final currentUser = userCredential.user;
      if (currentUser != null && !currentUser.emailVerified) {
        // Email chưa được xác thực, chuyển đến trang xác thực
        await currentUser.sendEmailVerification();
      }
      // if (user.status == 1) {
      //   throw const SignUp_AccountFailure('Tài khoản của bạn đã bị cấm');
      // }
    } on FirebaseAuthException catch (e) {
      final ex = SignUp_AccountFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw SignUp_AccountFailure(ex.message);
    } catch (_) {
      rethrow;
    }
  }
}
