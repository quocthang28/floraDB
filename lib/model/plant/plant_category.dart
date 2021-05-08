import 'package:cloud_firestore/cloud_firestore.dart';

class PlantCategory {
  PlantCategory(
      {required this.id,
      required this.vietnameseName,
      required this.scientificName,
      required this.shortDesc,
      required this.imageURLs});

  String id;
  String vietnameseName;
  String scientificName;
  String shortDesc;
  List<String> imageURLs;

  factory PlantCategory.fromSnapshot(DocumentSnapshot snapshot) {
    return PlantCategory(
      id: snapshot['id'],
      vietnameseName: snapshot['vietnamesename'],
      scientificName: snapshot['scientificname'],
      shortDesc: snapshot['shortdesc'],
      imageURLs: List.from(snapshot['imageurls']),
    );
  }

  factory PlantCategory.fromMap(Map data) {
    return PlantCategory(
      id: data['id'],
      vietnameseName: data['vietnamesename'],
      scientificName: data['scientificname'],
      shortDesc: data['shortdesc'],
      imageURLs: data['imageurls'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "vietnamesename": vietnameseName,
        scientificName: "scientificname",
        shortDesc: "shortdesc"
      };
}
