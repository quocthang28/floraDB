import 'package:floradb/common_widget/plant/plant_category_card.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlantCategoryGrid extends StatefulWidget {
  @override
  _PlantCategoryGridState createState() => _PlantCategoryGridState();
}

class _PlantCategoryGridState extends State<PlantCategoryGrid> {
  final PlantCategoryController _plantCategoryController = Get.find();

  Widget _buildCategoriesGrid() {
    List<Widget> cards = [];
    _plantCategoryController.plantCategoriesLD.forEach((element) {
      cards.add(PlantCategoryCard.buildInstance(element));
    });

    return GridView(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1,
      ),
      children: cards,
    );
  }

  @override
  void initState() {
    _plantCategoryController.getPlantCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildCategoriesGrid());
  }
}
