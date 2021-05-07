import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/model/user.dart';

class DatabaseService {
  DatabaseService();

  FirebaseFirestore _instance = FirebaseFirestore.instance;

  FirebaseFirestore get instance => _instance;

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
