import 'dart:math';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unimanga_app/app/constants/index.dart';
import 'package:unimanga_app/app/modules/home/views/home_views.dart';
import 'package:unimanga_app/app/modules/signin/bindings/signin_bindings.dart';
import 'package:unimanga_app/app/modules/signin/controllers/SignIn_Controller.dart';
import 'package:unimanga_app/app/modules/signin/repository/signin_repository.dart';

import '../../../global_widgets/button_custom.dart';
import '../../../models/user.dart';
import '../../signup/provider/signup_failer.dart';
import '../../signup/views/SignUp.dart';
import '../../update_pass/views/verificationscreen.dart';

//import 'SignUp.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen>
    with SingleTickerProviderStateMixin {
  final _frmkey = GlobalKey<FormState>();

  final _user = Get.put(SigninRepository());

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  late AnimationController controller;
  bool showProgress = false;
  bool _obscureText = true;
  bool? isChecked = false;
  bool visible = false;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _signIn() async {
    final user = Users(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (!_frmkey.currentState!.validate()) {
      showFailureDialog();
    } else {
      try {
        await _user.loginAccount(user);
      } on SignUp_AccountFailure catch (e) {
        await showFailureDialog(message: e.message);
      } catch (_) {
        showFailureDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 200,
                        image: AssetImage(AppImages.Logoapp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(height: 30.0),
                  Form(
                    key: _frmkey,
                    child: Column(
                      children: [
                        TextFormField(
                            style: const TextStyle(
                              color: Color(0xFF0597F2),
                              fontSize: 18,
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) {
                              if (email!.isEmpty) {
                                return 'Vui lòng nhập email';
                              }
                              return null;
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                          style: TextStyle(
                            color: Color(0xFF0597F2),
                            fontSize: 18,
                          ),
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color.fromARGB(255, 42, 43, 44),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            labelText: "Password",
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
                          obscureText: _obscureText,
                          validator: (pass) {
                            if (pass!.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            if (pass.length < 8) {
                              return 'Vui lòng nhập hơn 8 ký tự';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Colors.grey),
                      ),
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
                        _signIn();
                      },
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      color: Color(0xFFADDDFF),
                    )),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Bạn đã chưa có tài khoản ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 10, 130, 228)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> showFailureDialog({String? message}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh NOOOO!',
          message: message ?? "Đăng nhập thất bại",
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
