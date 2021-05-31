import 'package:floradb/model/plant/plant.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class PlantController extends GetxController {
  DatabaseService _databaseService = Get.find();
  //final plantsLD = <Plant>[].obs;
  final plantsByCategoryLD = <Plant>[].obs;

  // @override
  // void onInit() {
  //   plantsLD.bindStream(streamPlants());
  //   super.onInit();
  // }

  void createNewPlant() {
    // DocumentReference ref = _db.collection('plant).doc();
    // ref.set({
    //   "id": ref.id,
    //   // ... add more fields here
    // });
    //update();
  }

  Stream<List<Plant>> streamPlantsByCategory(String categoryID) {
    return _databaseService.firestore
        .collection('plant')
        .where('category_id', isEqualTo: categoryID)
        .snapshots()
        .map((snapshot) {
      List<Plant> plantsByCategory = [];
      snapshot.docs.forEach((element) {
        plantsByCategory.add(Plant.fromSnapshot(element));
      });
      return plantsByCategory;
    });
  }

  void getPlantsByCategory(String categoryID) {
    plantsByCategoryLD.clear();
    plantsByCategoryLD.bindStream(streamPlantsByCategory(categoryID));
  }

  // Stream<List<Plant>> streamPlants() {
  //   //todo: sort by created date (newest on top)
  //   return _databaseService.firestore
  //       .collection('plant')
  //       .snapshots()
  //       .map((snapshot) {
  //     List<Plant> plants = [];
  //     snapshot.docs.forEach((element) {
  //       plants.add(Plant.fromSnapshot(element));
  //     });
  //     return plants;
  //   });
  // }
}
