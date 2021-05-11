import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String userName;
  final String? avatarURL;

  UserModel(
      {required this.uid,
      required this.email,
      required this.userName,
      this.avatarURL});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      userName: data['username'],
      avatarURL: data['avatarurl'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      userName: snapshot['username'],
      avatarURL: snapshot['avatarurl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "username": userName};
}
