import 'package:floradb/common_widget/plant/plant_category_card.dart';
import 'package:floradb/common_widget/plant/plant_category_seemore.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryGrid extends StatelessWidget {
  final PlantCategoryController _plantCategoryController = Get.find();

  Widget _buildCategoriesGrid() {
    List<Widget> cards = [];
    //todo: add limit
    _plantCategoryController.plantCategoriesLD.forEach((element) {
      cards.add(PlantCategoryCard.buildInstance(element));
    });
    cards.add(PlantCategorySeeMore());

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5 / 1,
      ),
      children: cards,
    ).pSymmetric(h: 4.0);
  }

  // @override
  // void initState() {
  //   //_plantCategoryController.getPlantCategoryList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildCategoriesGrid());
  }
}
