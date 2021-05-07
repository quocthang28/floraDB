import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String userName;

  UserModel({required this.uid, required this.email, required this.userName});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      userName: data['username'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        userName: snapshot['username']);
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "username": userName};
}
