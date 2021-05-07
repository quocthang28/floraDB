import 'package:cloud_firestore/cloud_firestore.dart';

class PlantCategory {
  PlantCategory(
      {required this.id,
      required this.vietnameseName,
      required this.scientificName,
      required this.shortDesc,
      required this.imageURL});

  String id;
  String vietnameseName;
  String scientificName;
  String shortDesc;
  String imageURL;

  factory PlantCategory.fromSnapshot(DocumentSnapshot snapshot) {
    return PlantCategory(
      id: snapshot['id'],
      vietnameseName: snapshot['vietnamesename'],
      scientificName: snapshot['scientificname'],
      shortDesc: snapshot['shortdesc'],
      imageURL: snapshot['imageurl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "vietnamesename": vietnameseName,
        scientificName: "scientificname",
        shortDesc: "shortdesc"
      };
}
