import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';

class UserService {
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Users?> getUserByUid(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await _firestore.collection('Users').doc(uid).get();
      if (documentSnapshot.exists) {
        return Users.fromSnapshot(documentSnapshot);
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}