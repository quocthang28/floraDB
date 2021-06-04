import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/model/forum/thread.dart';

class ForumCategory {
  ForumCategory(
      {required this.id, required this.title, required this.threadIDs});

  final String id;
  final String title;
  final List<String> threadIDs;

  factory ForumCategory.fromSnapshot(DocumentSnapshot snapshot) {
    return ForumCategory(
        id: snapshot.id,
        title: snapshot['title'],
        threadIDs: List.from(snapshot['threadids']));
  }
}
