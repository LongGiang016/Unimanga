import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/modules/signin/views/signin.dart';
import 'package:unimanga_app/app/modules/signup/views/vertification.dart';
import '../../models/user.dart';
import '../home/views/home_views.dart';
import '../list_ranking/views/component/list_topthree.dart';
import '../signup/provider/signup_failer.dart';
import '../signup/views/SignUp.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser = Rx<User?>(null);
  // late Timer timer;
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => HomeView());
    } else {
      if (user.emailVerified) {
        updateUserStatusByEmail(user.email!);
      } else {
        Get.offAll(() => Vertification());
      }
    }
  }

  loginAccount(Users user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password.toString(),
      );
    } on FirebaseAuthException catch (e) {
      final ex = SignUp_AccountFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw SignUp_AccountFailure(ex.message);
    } catch (_) {}
  }

  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final ex = SignUp_AccountFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw SignUp_AccountFailure(ex.message);
    } catch (_) {}
  }

  Future<void> logout(BuildContext context,
      {required Function nextRoute}) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(nextRoute);
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error logging out: $e');
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!;
    AuthCredential credential =
        EmailAuthProvider.credential(email: user.email!, password: oldPassword);
    try {
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      await postDetailsToFirestore(Users(password: newPassword));
    } on FirebaseAuthException catch (e) {
      final ex = SignUp_AccountFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw SignUp_AccountFailure(ex.message);
    }
  }

  postDetailsToFirestore(Users user) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var _user = _auth.currentUser;
    CollectionReference usersRef = firebaseFirestore.collection('Users');

    Map<String, dynamic> userData = {
      'password': user.password,
    };

    await usersRef.doc(_user!.uid).update(userData);
  }

  Future<Users?> updateUserStatusByEmail(String email) async {
    try {
      // Truy cập vào collection 'Users' trong Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      // Kiểm tra xem có tài liệu người dùng nào không
      if (querySnapshot.docs.isNotEmpty) {
        // Lấy tài liệu người dùng đầu tiên
        DocumentSnapshot userDoc = querySnapshot.docs.first;

        // Lấy trạng thái hiện tại của người dùng
        int currentStatus = userDoc.get('status');

        if (currentStatus == 0) {
          Get.offAll(() => HomeView());
        } else if (currentStatus == 1) {
          FirebaseAuth.instance.signOut();
          Get.offAll(() => HomeView());
        }
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Lỗi khi cập nhật trạng thái người dùng: $e');
      rethrow;
    }
  }
}
