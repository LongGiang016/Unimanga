import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class stringFirebase{
  static final StringHost = 'UniManga';
  static final databaseconnect = FirebaseDatabase.instanceFor(app: Firebase.app(), databaseURL:'https://unimanga-37d5f-default-rtdb.asia-southeast1.firebasedatabase.app/' );
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
}