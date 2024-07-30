import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../signin/views/signin.dart';
import '../../signup/provider/signup_failer.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => VerificationState();
}

class VerificationState extends State<ForgotPassword>
    with SingleTickerProviderStateMixin {
  final _frmkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    if (_frmkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        await showDoneDialog();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Login_Screen(),
          ),
        );
      } on SignUp_AccountFailure catch (e) {
        await showFailureDialog(message: e.message);
      } catch (_) {
        await showFailureDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Nhập Email',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(double.minPositive),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vui lòng nhập email',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'để thay đổi mật khẩu',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
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
                              borderSide: const BorderSide(
                                color: Color(0xFFADDDFF),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (email) {
                            if (email!.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            // if (!isValidEmail(email)) {
                            //   return 'Vui lòng nhập đúng định dang !';
                            // }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    )),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(double.minPositive),
                  child: Center(
                      child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    elevation: 5.0,
                    height: 50,
                    minWidth: double.infinity,
                    onPressed: () {
                      passwordReset();
                    },
                    child: const Text(
                      "Tiếp tục",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    color: const Color(0xFFADDDFF),
                  )),
                ),
                const SizedBox(height: 16),
                Lottie.asset('assets/animations/email.json',
                    repeat: true,
                    reverse: true,
                    // controller: controller,
                    // onLoaded: (composition) {
                    //   controller.duration = composition.duration;
                    //   controller.forward();
                    // },
                    fit: BoxFit.cover),
              ]),
        ));
  }

  Future<void> showDoneDialog() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/login_successly.json',
              repeat: false,
              controller: controller,
              onLoaded: (composition) {
                controller.duration = composition.duration;
                controller.forward();
              },
            ),
            const Text(
              "Email xác thật đã được gửi",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> showFailureDialog({String? message}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/login_failure.json',
              repeat: false,
              controller: controller,
              onLoaded: (composition) {
                controller.duration = composition.duration;
                controller.forward();
              },
            ),
            Text(
              message ?? "Đổi mật khẩu thất bại",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
