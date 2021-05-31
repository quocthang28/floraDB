import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  Plant(
      {required this.categoryID,
      required this.id,
      required this.name,
      required this.scientificName,
      required this.desc,
      required this.imageURLs});

  final String categoryID;
  final String id;
  final String name;
  final String scientificName;
  final String desc;
  final List<String> imageURLs; // image by poster
  //final String List<String> usersImageURLs; // image by users

  factory Plant.fromSnapshot(DocumentSnapshot snapshot) {
    return Plant(
      categoryID: snapshot['category_id'],
      id: snapshot.id,
      name: snapshot['name'],
      scientificName: snapshot['scientificname'],
      desc: snapshot['desc'],
      imageURLs: List.from(snapshot['imageurls']),
    );
  }

  Map<String, dynamic> toJson() => {
        "category_id": categoryID,
        "id": id,
        "name": name,
        "scientificname": scientificName,
        "desc": desc,
        "imageURLs": imageURLs,
      };
}
