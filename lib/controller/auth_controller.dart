import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floradb/common_widget/loading_indicator.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
        .collection('users')
        .doc('${_firebaseUser.value!.uid}')
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
    }

    if (_firebaseUser == null) {
      Get.offAllNamed(SiteNavigation.LOGIN);
    } else {
      Get.offAllNamed(SiteNavigation.MAIN);
      //Get.offAllNamed(SiteNavigation.HOME);
    }
  }

  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  Future<void> signUp(
      String email, String password, String name, BuildContext context) async {
    try {
      showLoadingIndicator(context);
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        if (name.isNotEmpty) {
          UserModel _newUser = UserModel(
              uid: result.user!.uid,
              email: result.user!.email!,
              userName: name,
              avatarURL:
                  "https://firebasestorage.googleapis.com/v0/b/floradb-bdef1.appspot.com/o/user_avatar%2Fdefaultavatar.png?alt=media&token=3f537dc5-2ecc-4225-8993-318e13c7eab7");
          _createUserFirestore(_newUser, result.user!);
        } else {
          Get.snackbar('L??i ????ng ki?? ta??i khoa??n', 'Thi????u username!');
        }
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar('L????i ????ng ki?? ta??i khoa??n', e.message.toString());
    }
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      showLoadingIndicator(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Get.snackbar('L????i ????ng nh????p', e.message.toString());
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('L????i ????ng xu????t', e.message.toString());
    }
  }
}
