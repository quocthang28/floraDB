import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserController extends GetxController {
  DatabaseService _databaseService = Get.find();
  AuthController _authController = Get.find();

  Future<List<UserModel>> getUserList() async {
    CollectionReference usersRef =
        _databaseService.firestore.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    return querySnapshot.docs
        //.where((element) => element['username'] == 'hihi')
        .map((doc) => UserModel.fromSnapshot(doc))
        .toList();
  }

  Future<List<UserModel>> getCurrentUserInfo() async {
    String uid = _authController.firebaseUser.value?.uid ?? '';
    CollectionReference usersRef =
        _databaseService.firestore.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    return querySnapshot.docs
        .where((element) => element['uid'] == uid)
        .map((doc) => UserModel.fromSnapshot(doc))
        .toList();
  }

  void changeAvatar() async {
    final picker = ImagePicker();
    PickedFile? image;
    String avatarUrl;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await picker.getImage(source: ImageSource.gallery);
      if (image != null) {
        var file = File(image.path);

        Reference reference = _databaseService.storage
            .ref()
            .child('user_avatar/${_authController.firestoreUser.value!.uid}');

        UploadTask uploadTask = reference.putFile(file);

        uploadTask.whenComplete(() async {
          avatarUrl = await uploadTask.snapshot.ref.getDownloadURL();
          _databaseService.firestore
              .collection('users')
              .doc(_authController.firestoreUser.value!.uid)
              .set({'avatarurl': avatarUrl}, SetOptions(merge: true));
          Get.snackbar('Đổi ảnh đại diện thành công', '');
        });
      }
    } else {
      print('cc');
    }
  }
}
