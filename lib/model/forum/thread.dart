import 'package:cloud_firestore/cloud_firestore.dart';

class ForumThread {
  ForumThread(
      {required this.id,
      required this.poster,
      required this.posterAvatar,
      required this.categoryID,
      required this.title,
      required this.content,
      required this.replies,
      required this.createdOn,
      required this.attachedImage});

  String id;
  String poster;
  String posterAvatar;
  String categoryID;
  String title;
  String content;
  num replies;
  DateTime createdOn;
  String attachedImage;

  factory ForumThread.fromSnapshot(DocumentSnapshot snapshot) {
    return ForumThread(
      id: snapshot.id,
      poster: snapshot['poster'],
      posterAvatar: snapshot['posteravatar'],
      categoryID: snapshot['categoryid'],
      title: snapshot['title'],
      content: snapshot['content'],
      replies: snapshot['replies'],
      createdOn: snapshot['created_on'].toDate(),
      attachedImage: snapshot['attachedimage'],
    );
  }

  factory ForumThread.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return ForumThread(
      id: snapshot.id,
      poster: snapshot['poster'],
      posterAvatar: snapshot['posteravatar'],
      categoryID: snapshot['categoryid'],
      title: snapshot['title'],
      content: snapshot['content'],
      replies: snapshot['replies'],
      createdOn: snapshot['created_on'].toDate(),
      attachedImage: snapshot['attachedimage'],
    );
  }

  Map<String, dynamic> toJson() => {
        "poster": poster,
        "posteravatar": posterAvatar,
        "categoryid": categoryID,
        "title": title,
        "content": content,
        "replies": 0,
        "created_on": Timestamp.fromDate(createdOn),
        "attachedimage": attachedImage
      };
}
