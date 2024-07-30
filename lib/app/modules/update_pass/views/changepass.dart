import 'dart:math';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/modules/auth/firebase_service.dart';
import 'package:unimanga_app/app/modules/infor_user/views/profile_screen.dart';

import '../../signup/provider/signup_failer.dart';

//import 'SignUp.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _frmkey = GlobalKey<FormState>();

  final _user = Get.put(AuthService());

  final TextEditingController oldController = new TextEditingController();
  final TextEditingController newController = new TextEditingController();

  bool showProgress = false;
  bool old_obscureText = true;
  bool new_obscureText = true;

  bool visible = false;
  void _changePassword() {
    try {
      _user.changePassword(
          oldController.text.toString(), newController.text.toString());
      showDoneDialog();
    } on SignUp_AccountFailure catch (e) {
      showFailureDialog(message: e.message);
    } catch (_) {
      showFailureDialog();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đổi mật khẩu"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _frmkey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                            color: Color(0xFF0597F2),
                            fontSize: 18,
                          ),
                          controller: oldController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                old_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color.fromARGB(255, 42, 43, 44),
                              ),
                              onPressed: () {
                                setState(() {
                                  old_obscureText = !old_obscureText;
                                });
                              },
                            ),
                            labelText: "Mật khẩu cũ",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFADDDFF),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          obscureText: old_obscureText,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(
                            color: Color(0xFF0597F2),
                            fontSize: 18,
                          ),
                          controller: newController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                new_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color.fromARGB(255, 42, 43, 44),
                              ),
                              onPressed: () {
                                setState(() {
                                  new_obscureText = !new_obscureText;
                                });
                              },
                            ),
                            labelText: "Mật khẩu mới",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFADDDFF),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          obscureText: new_obscureText,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Center(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      elevation: 5.0,
                      height: 45,
                      minWidth: double.infinity,
                      onPressed: () {
                        setState(() {
                          visible = true;
                        });
                        _changePassword();
                      },
                      child: Text(
                        "Đổi mật khẩu",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      color: Color(0xFFADDDFF),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> showDoneDialog() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh WOWWW!',
          message: "Đổi mật khẩu thành công",
          contentType: ContentType.success,
        ),
      ),
    );
  }

  Future<void> showFailureDialog({String? message}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh NOOOO!',
          message: message ?? "Đổi mật khẩu thất bại",
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
