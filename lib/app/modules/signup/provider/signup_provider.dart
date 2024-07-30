import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:unimanga_app/app/constants/app_strings_firebase.dart';
import '../../../models/user.dart';
import '../../auth/firebase_service.dart';
import 'signup_failer.dart';

// class SignupProvider extends GetxController {
//   static SignupProvider get instance => Get.find();
//   final _auth = FirebaseAuth.instance;
//   final _db = FirebaseFirestore.instance;
//   // Tạo user
//   createUser(Users user) async {
//     try {
//       await _auth
//           .createUserWithEmailAndPassword(
//               email: user.email, password: user.password.toString())
//           .then((value) => postDetailsToFirestore(user));
//     } on FirebaseAuthException catch (e) {
//       final ex = SignUp_AccountFailure.code(e.code);
//       print('FIREBASE AUTH EXCEPTION - ${ex.message}');
//       throw ex;
//     } catch (_) {}
//   }

//   // Lưu trữ vào firestore
//   postDetailsToFirestore(Users user) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     var _user = _auth.currentUser;
//     CollectionReference usersRef = firebaseFirestore.collection('Users');

//    Map<String, dynamic> userData = {
//   'id': user.id,
//   'imageUrl': user.imageUrl,
//   'name': user.name,
//   'email': user.email,
//   'password': user.password,
//   'score': user.score,
// };

//     await usersRef.doc(_user!.uid).set(userData);
//   }

//   // lấy 1 user
//   Future<Users> getUserDetails(String email) async {
//     final snapshot =
//         await _db.collection('Users').where('Email', isEqualTo: email).get();
//     final userData = snapshot.docs.map((e) => Users.fromSnapshot(e)).single;
//     return userData;
//   }

//   // lấy tất cả
//   Future<Users> allUser() async {
//     final snapshot = await _db.collection('Users').get();
//     final userData = snapshot.docs.map((e) => Users.fromSnapshot(e)).single;
//     return userData;
//   }
// }
class SignupProvider extends GetxController {
  static SignupProvider get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  final   auth = Get.put(AuthService());
  // Tạo user
  createUser(Users user) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password.toString())
          .then((value) async {
            await postDetailsToFirestore(user);
            await createNewAccountUser(value.user!.uid);
          });
      auth.setInitialScreen(auth.firebaseUser as User?);
    } on FirebaseAuthException catch (e) {
      final ex = SignUp_AccountFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (_) {}
  }

  // Lưu trữ vào firestore
  postDetailsToFirestore(Users user) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var _user = _auth.currentUser;
    CollectionReference usersRef = firebaseFirestore.collection('Users');

    Map<String, dynamic> userData = {
      'id':'',
      'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/unimanga-37d5f.appspot.com/o/Users%2Flogo.jpg?alt=media&token=d2aa5b5e-ed06-4b0f-9c57-fcebe2699088',
      'name': user.name,
      'email': user.email,
      'address': '',
      'password': user.password,
      'score': 0,
      'status':0,
      'statuscomic':0,
    };

    await usersRef.doc(_user!.uid).set(userData);
  }
  Future<void> createNewAccountUser(String acc) async {
      try {
        DatabaseReference accountRef = stringFirebase.databaseconnect.ref(stringFirebase.StringHost);
        await accountRef.child('TaiKhoan').child(acc).set({
          "TruyenDaDoc": [],
          "TruyenDaLuu":[],
          "TruyenDaThich":[],
          "TruyenYeuThich":[],
          "ChuongTruyenDaMoKhoa":[]
        });
        print("Account $acc created successfully.");
      } catch (e) {
        print("Error creating new account: $e");
      }
    }

}
