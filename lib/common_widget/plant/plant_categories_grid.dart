import 'package:floradb/common_widget/plant/plant_category_card.dart';
import 'package:floradb/common_widget/plant/plant_category_seemore.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryGrid extends StatelessWidget {
  PlantCategoryGrid({required this.haveSeeMore});

  final bool haveSeeMore;

  final PlantCategoryController _plantCategoryController = Get.find();

  Widget _buildCategoriesGrid() {
    List<Widget> cards = [];
    //todo: add limit
    if (!haveSeeMore) {
      //full list
      _plantCategoryController.plantCategoriesLD.forEach((element) {
        cards.add(PlantCategoryCard.buildInstance(element));
      });
    }
    if (haveSeeMore) {
      //todo: show category with most plants (query plantcategory order by count descending)
      // only show 6
      int count = _plantCategoryController.plantCategoriesLD.length < 6
          ? _plantCategoryController.plantCategoriesLD.length
          : 6;
      for (int i = 0; i < count - 1; i++) {
        cards.add(PlantCategoryCard.buildInstance(
            _plantCategoryController.plantCategoriesLD[i]));
      }
      cards.add(PlantCategorySeeMore());
    }

    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
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
