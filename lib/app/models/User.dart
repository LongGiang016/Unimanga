import 'package:cloud_firestore/cloud_firestore.dart';


class Users {
  final String? imageUrl;
  final String? name;
  final String? email;
  final String? address;
  final String? password;
  final int? score;
  final int? status;
  int? statuscomic;

  Users(
      {this.imageUrl,
      this.name,
      this.email,
      this.address,
      this.password,
      this.score,
      this.statuscomic,
      this.status});

  get value => null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'score': score,
      'status': status,
      'statuscomic': statuscomic
    };
  }

  factory Users.fromSnapshot(
      DocumentSnapshot<Map<dynamic, dynamic>?> document) {
    final data = document.data();

    if (data == null) {
      throw StateError("Missing data for Users from snapshot");
    }

    return Users(
        imageUrl: data['imageUrl'] as String? ?? '',
        name: data['name'] as String? ?? '',
        email: data['email'] as String? ?? '',
        address: data['address'] as String? ?? '',
        password: data['password'] as String? ?? '',
        score: data['score'] as int? ?? 0,
        status: data['status'] as int? ?? 0,
        statuscomic: data['statuscomic'] as int? ??0,
        
        );

  }
}
