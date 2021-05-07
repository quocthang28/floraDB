import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/model/plant/plant_category.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class PlantCategoryController extends GetxController {
  DatabaseService _databaseService = Get.find();
  final plantCategoriesLD = <PlantCategory>[].obs;

  void getPlantCategoryList() async {
    CollectionReference usersRef = _databaseService.instance
        .collection('plant_category'); //todo: add name to const class
    QuerySnapshot querySnapshot = await usersRef.get();
    plantCategoriesLD.addAll(querySnapshot.docs
        .map((doc) => PlantCategory.fromSnapshot(doc))
        .toList());
  }
}
