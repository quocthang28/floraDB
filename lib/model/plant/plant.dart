import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  Plant({required this.categoryID, required this.name});

  final String categoryID;
  final String name;

  factory Plant.fromSnapshot(DocumentSnapshot snapshot) {
    return Plant(
      categoryID: snapshot['category_id'],
      name: snapshot['name'],
    );
  }

  factory Plant.fromMap(Map data) {
    return Plant(
      categoryID: data['category_id'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "category_id": categoryID,
        "name": name,
      };
}
