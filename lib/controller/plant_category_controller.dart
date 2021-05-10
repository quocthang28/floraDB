import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/model/plant/plant_category.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class PlantCategoryController extends GetxController {
  DatabaseService _databaseService = Get.find();
  final plantCategoriesLD = <PlantCategory>[].obs;
  var plantCategoryLD = Rxn<PlantCategory>();

  @override
  void onInit() {
    plantCategoriesLD.bindStream(streamPlantCategories());
    super.onInit();
  }

  Stream<List<PlantCategory>> streamPlantCategories() {
    return _databaseService.firestore
        .collection('plant_category')
        .snapshots()
        .map((snapshot) {
      List<PlantCategory> categories = [];
      snapshot.docs.forEach((element) {
        categories.add(PlantCategory.fromSnapshot(element));
      });
      return categories;
    });
  }

  // void getPlantCategoryList() async {
  //   CollectionReference usersRef = _databaseService.instance
  //       .collection('plant_category'); //todo: add name to const class
  //   QuerySnapshot querySnapshot = await usersRef.get();
  //   if (plantCategoriesLD.isNotEmpty) {
  //     plantCategoriesLD.clear();
  //   }
  //   plantCategoriesLD.addAll(querySnapshot.docs
  //       .map((doc) => PlantCategory.fromSnapshot(doc))
  //       .toList());
  // }
}
