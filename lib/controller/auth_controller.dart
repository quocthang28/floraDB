import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floradb/common_widget/loading_indicator.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/service/database_service.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //DatabaseService _db = Get.find();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> _firebaseUser = Rxn<User>();
  Rxn<UserModel> _firestoreUser = Rxn<UserModel>();

  Rxn<User> get firebaseUser => _firebaseUser;

  Rxn<UserModel> get firestoreUser => _firestoreUser;

  RxBool _isAd = false.obs;

  RxBool get isAd => _isAd;

  Stream<User?> get userState =>
      _auth.authStateChanges(); // check sign in sign out

  Future<User?> get currentUser async => _auth.currentUser;

  @override
  void onInit() {
    _firebaseUser.bindStream(userState);
    ever(_firebaseUser,
        handleAuthChanged); // called handleAuthChanged every time _firebaseUser changes
    super.onInit();
  }

  Stream<UserModel> streamFirestoreUser() {
    // return user data from firestore

    return _db
        .doc('/users/${_firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  Future<void> isAdmin() async {
    await currentUser.then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').doc(user!.uid).get();
      if (adminRef.exists) {
        _isAd.value = true;
      } else {
        _isAd.value = false;
      }
      update();
    });
  }

  void handleAuthChanged(User? _firebaseUser) async {
    if (_firebaseUser?.uid != null) {
      // logged in
      _firestoreUser.bindStream(
          streamFirestoreUser()); // bind user from firestore to local
      await isAdmin();
      print(_firestoreUser.value?.email);
    }

    if (_firebaseUser == null) {
      Get.offAllNamed(SiteNavigation.LOGIN);
    } else {
      Get.offAllNamed(SiteNavigation.HOME);
    }
  }

  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        UserModel _newUser = UserModel(
            uid: result.user!.uid, email: result.user!.email!, userName: name);
        _createUserFirestore(_newUser, result.user!);
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error signing up', e.message.toString());
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      showLoadingIndicator(context);
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => Navigator.pop(context))
          .onError((_, __) => Navigator.pop(context));
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error logging in', e.message.toString());
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error signing out', e.message.toString());
    }
  }
}
