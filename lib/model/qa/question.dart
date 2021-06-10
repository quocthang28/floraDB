import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  Question(
      {required this.id,
      required this.posterID,
      required this.posterName,
      required this.posterAvatar,
      required this.title,
      required this.content,
      required this.attachedImage,
      required this.createdOn,
      required this.replies});

  String id;
  String posterID;
  String posterName;
  String posterAvatar;
  String title;
  String content;
  String attachedImage;
  DateTime createdOn;
  int replies;

  factory Question.fromSnapshot(DocumentSnapshot snapshot) {
    return Question(
        id: snapshot.id,
        posterID: snapshot['posterid'],
        posterName: snapshot['postername'],
        posterAvatar: snapshot['posteravatar'],
        title: snapshot['title'],
        content: snapshot['content'],
        attachedImage: snapshot['attachedimage'],
        createdOn: snapshot['created_on'].toDate(),
        replies: snapshot['replies']);
  }

  factory Question.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return Question(
        id: snapshot.id,
        posterID: snapshot['posterid'],
        posterName: snapshot['postername'],
        posterAvatar: snapshot['posteravatar'],
        title: snapshot['title'],
        content: snapshot['content'],
        attachedImage: snapshot['attachedimage'],
        createdOn: snapshot['created_on'].toDate(),
        replies: snapshot['replies']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "posterid": posterID,
        "postername": posterName,
        "posteravatar": posterAvatar,
        "title": title,
        "content": content,
        "attachedimage": attachedImage,
        "created_on": Timestamp.fromDate(createdOn),
        "replies": 0
      };
}
