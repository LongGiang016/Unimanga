import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../../constants/app_images.dart';
import '../../../models/user.dart';
import '../../home/views/home_views.dart';
import 'package:path/path.dart' as Path;

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  String userUid = '';
  dynamic credentials;
  var isProfileUploading = false.obs;

  // upload ảnh
  uploadImage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);
    var reference = FirebaseStorage.instance
        .ref()
        .child('Users/$fileName'); // Modify this path/string as your need
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then(
      (value) {
        imageUrl = value;
        print("Download URL: $value");
      },
    );

    return imageUrl;
  }

  // Cập nhật thông in user
  updateUserInfo(
    File? selectedImage,
    String? name,
    String? address, {
    String? existingImageUrl,
  }) async {
    String url_new = '';

    if (selectedImage != null) {
      url_new = await uploadImage(selectedImage);
    } else if (existingImageUrl != null) {
      url_new = existingImageUrl;
    } else {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> defaultImageDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      url_new = defaultImageDoc.data()?['imageUrl'] ?? '';
    }

    String uid = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> userData = {
      'imageUrl': url_new,
      'name': name,
      'address': address,
    };

    await FirebaseFirestore.instance.collection('Users').doc(uid).set(
          userData,
          SetOptions(merge: true),
        );

    isProfileUploading(false);
    Get.to(() => HomeView());
  }

  // Lấy thông tin User

  Future<Map<String, dynamic>> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    if (userSnapshot.exists) {
      return userSnapshot.data()!;
    } else {
      return {};
    }
  }

  // Lấy tất cả

  Future<List<Map<String, dynamic>>> getAllUserData() async {
    QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    List<Map<String, dynamic>> userData = [];

    for (DocumentSnapshot<Map<String, dynamic>> doc in userSnapshot.docs) {
      userData.add(doc.data()!);
    }

    return userData;
  }
}
