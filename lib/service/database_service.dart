import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  DatabaseService();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  FirebaseFirestore get firestore => _firestore;
  FirebaseStorage get storage => _firebaseStorage;

  // Future<List<UserModel>> getUserList() async {
  //   CollectionReference usersRef = _instance.collection('users');
  //   QuerySnapshot querySnapshot = await usersRef.get();
  //   return querySnapshot.docs
  //       //.where((element) => element['username'] == 'A')
  //       .map((doc) => UserModel.fromSnapshot(doc))
  //       .toList();
  // }
  //
  // Future<List<QueryDocumentSnapshot<Object?>>> getDocsByCollection(
  //     String collection) async {
  //   CollectionReference colRef = _instance.collection(collection);
  //   QuerySnapshot querySnapshot = await colRef.get();
  //   return querySnapshot.docs.toList();
  // }
  //
  // //get info by user uid;
}
