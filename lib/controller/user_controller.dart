import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  DatabaseService _databaseService = Get.find();
  AuthController _authController = Get.find();

  Future<List<UserModel>> getUserList() async {
    CollectionReference usersRef =
        _databaseService.instance.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    return querySnapshot.docs
        //.where((element) => element['username'] == 'hihi')
        .map((doc) => UserModel.fromSnapshot(doc))
        .toList();
  }

  Future<List<UserModel>> getCurrentUserInfo() async {
    String uid = _authController.firebaseUser.value?.uid ?? '';
    CollectionReference usersRef =
        _databaseService.instance.collection('users');
    QuerySnapshot querySnapshot = await usersRef.get();
    return querySnapshot.docs
        .where((element) => element['uid'] == uid)
        .map((doc) => UserModel.fromSnapshot(doc))
        .toList();
  }
}
