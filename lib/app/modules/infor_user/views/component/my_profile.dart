import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimanga_app/app/global_widgets/text_field_custom2.dart';
import 'package:unimanga_app/app/modules/infor_user/controller/user_controller.dart';
import 'package:unimanga_app/app/modules/infor_user/repository/user_repository.dart';
import '../../../../global_widgets/appbar_custom.dart';
import '../../../../global_widgets/button_custom.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  UserRepository authController = Get.put(UserRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map<String, dynamic> _userData = {};
  final ImagePicker _picker = ImagePicker();
  var isProfileUploading = false.obs;
  File? selectedImage;
 final firebaseUser = FirebaseAuth.instance.currentUser!.uid;
  // hàm lấy ảnh
  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }
File? _image;
 final picker = ImagePicker();
//  final database = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL:'https://unimanga-37d5f-default-rtdb.asia-southeast1.firebasedatabase.app/' );
 final Future<FirebaseApp> initialization = Firebase.initializeApp();
 Future getImageee() async {
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  setState(() {
    if(pickedImage != null){
      _image = File(pickedImage.path);
    }else{
      print("Khong co ảnh được chọn");
    }
  });
 }


  // Hàm lấy dữ liệu
  Future<void> _loadUserData() async {
    _userData = await authController.getUserData();
    setState(() {
      nameController = TextEditingController(text: _userData['name']);
      addressController = TextEditingController(text: _userData['address']);
    });
  }

  // Fech dữ liệu
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.4,
              child: Stack(
                children: [
                  IntroWidgetWithoutLogo(),
                  Positioned(
                    top: 20,
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        getImageee();
                      },
                      child: _image == null
                          ? _userData['imageUrl'] != null
                              ? Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _userData['imageUrl']!),
                                          fit: BoxFit.fill),
                                      shape: BoxShape.circle,
                                      color: Color(0xffD6D6D6)),
                                )
                              : Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffD6D6D6)),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                          : Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.fill),
                                  shape: BoxShape.circle,
                                  color: Color(0xffD6D6D6)),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(
                        color: Color(0xFF0597F2),
                        fontSize: 18,
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Họ và Tên",
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
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Vui lòng nhập Họ Tên';
                        }
                         if (name.length < 5) {
                          return 'Vui lòng nhập hơn 5 ký tự';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      style: const TextStyle(
                        color: Color(0xFF0597F2),
                        fontSize: 18,
                      ),
                      controller: addressController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Địa chỉ",
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
                      validator: (address) {
                        if (address!.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        if (address.length < 5) {
                          return 'Vui lòng nhập hơn 5 ký tự';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() => isProfileUploading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton('Cập nhật', () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }

                            isProfileUploading(true);
                            authController.updateUserInfo(_image,
                                nameController.text, addressController.text);
                            
                          })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
