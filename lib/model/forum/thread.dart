import 'package:cloud_firestore/cloud_firestore.dart';

class ForumThread {
  ForumThread({
    required this.poster,
    required this.posterAvatar,
    required this.categoryID,
    required this.title,
    required this.content,
    required this.replies,
    required this.createdOn,
  });

  final String poster;
  final String posterAvatar;
  final String categoryID;
  final String title;
  final String content;
  final num replies;
  final DateTime createdOn;

  factory ForumThread.fromSnapshot(DocumentSnapshot snapshot) {
    return ForumThread(
      poster: snapshot['poster'],
      posterAvatar: snapshot['posteravatar'],
      categoryID: snapshot['categoryid'],
      title: snapshot['title'],
      content: snapshot['content'],
      replies: snapshot['replies'],
      createdOn: snapshot['created_on'].toDate(),
    );
  }

  factory ForumThread.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return ForumThread(
      poster: snapshot['poster'],
      posterAvatar: snapshot['posteravatar'],
      categoryID: snapshot['categoryid'],
      title: snapshot['title'],
      content: snapshot['content'],
      replies: snapshot['replies'],
      createdOn: snapshot['created_on'].toDate(),
    );
  }
}
