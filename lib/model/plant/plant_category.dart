import 'package:cloud_firestore/cloud_firestore.dart';

class PlantCategory {
  PlantCategory(
      {required this.id,
      required this.vietnameseName,
      required this.shortDesc,
      required this.imageURLs});

  String id;
  String vietnameseName;
  String shortDesc;
  List<String> imageURLs;

  factory PlantCategory.fromSnapshot(DocumentSnapshot snapshot) {
    return PlantCategory(
      id: snapshot['id'],
      vietnameseName: snapshot['vietnamesename'],
      shortDesc: snapshot['shortdesc'],
      imageURLs: List.from(snapshot['imageurls']),
    );
  }

  factory PlantCategory.fromMap(Map data) {
    return PlantCategory(
      id: data['id'],
      vietnameseName: data['vietnamesename'],
      shortDesc: data['shortdesc'],
      imageURLs: data['imageurls'],
    );
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "vietnamesename": vietnameseName, shortDesc: "shortdesc"};
}
