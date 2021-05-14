import 'package:floradb/model/plant/plant.dart';
import 'package:floradb/service/database_service.dart';
import 'package:get/get.dart';

class PlantController extends GetxController {
  DatabaseService _databaseService = Get.find();
  final plantsLD = <Plant>[].obs;

  @override
  void onInit() {
    plantsLD.bindStream(streamPlants());
    super.onInit();
  }

  Stream<List<Plant>> streamPlants() {
    //todo: sort by created date (newest on top)
    return _databaseService.firestore
        .collection('plant')
        .snapshots()
        .map((snapshot) {
      List<Plant> plants = [];
      snapshot.docs.forEach((element) {
        plants.add(Plant.fromSnapshot(element));
      });
      return plants;
    });
  }
}
