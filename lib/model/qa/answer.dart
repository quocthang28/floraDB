import 'package:cloud_firestore/cloud_firestore.dart';

class Answer {
  Answer(
      {required this.questionID,
      required this.posterID,
      required this.posterName,
      required this.posterAvatar,
      required this.createdOn,
      required this.likes,
      required this.dislikes,
      required this.content});

  String questionID;
  String posterID;
  String posterName;
  String posterAvatar;
  DateTime createdOn;
  int likes;
  int dislikes;
  String content;
  //todo: add attached image

  factory Answer.fromSnapshot(DocumentSnapshot snapshot) {
    return Answer(
        questionID: snapshot['questionid'],
        posterID: snapshot['posterid'],
        posterName: snapshot['postername'],
        posterAvatar: snapshot['posteravatar'],
        createdOn: snapshot['created_on'].toDate(),
        likes: snapshot['likes'],
        dislikes: snapshot['dislikes'],
        content: snapshot['content']);
  }

  factory Answer.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return Answer(
        questionID: snapshot['questionid'],
        posterID: snapshot['posterid'],
        posterName: snapshot['postername'],
        posterAvatar: snapshot['posteravatar'],
        createdOn: snapshot['created_on'].toDate(),
        likes: snapshot['likes'],
        dislikes: snapshot['dislikes'],
        content: snapshot['content']);
  }

  Map<String, dynamic> toJSON() => {
        "questionid": questionID,
        "posterid": posterID,
        "postername": posterName,
        "posteravatar": posterAvatar,
        "created_on": Timestamp.fromDate(createdOn),
        "likes": likes,
        "dislikes": dislikes,
        "content": content,
      };
}
