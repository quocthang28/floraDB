import 'package:cloud_firestore/cloud_firestore.dart';

class ThreadReply {
  ThreadReply(
      {required this.posterID,
      required this.threadID,
      required this.userName,
      required this.avatarUrl,
      required this.createdOn,
      required this.content,
      required this.attachedImage});

  String posterID;
  String threadID;
  String userName;
  String avatarUrl;
  DateTime createdOn;
  String content;
  String attachedImage;

  factory ThreadReply.fromQuerySnapshot(QueryDocumentSnapshot snapshot) {
    return ThreadReply(
        posterID: snapshot['posterid'],
        threadID: snapshot['threadid'],
        userName: snapshot['username'],
        avatarUrl: snapshot['avatarurl'],
        createdOn: snapshot['created_on'].toDate(),
        content: snapshot['content'],
        attachedImage: snapshot['attachedimage']);
  }

  Map<String, dynamic> toJson() => {
        "posterid": posterID,
        "avatarurl": avatarUrl,
        "content": content,
        "created_on": Timestamp.fromDate(createdOn),
        "threadid": threadID,
        "username": userName,
        "attachedimage": attachedImage,
      };
}
