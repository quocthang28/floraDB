import 'package:floradb/model/plant/plant_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryDetail extends StatelessWidget {
  final PlantCategory _plantCategory = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _plantCategory.shortDesc.text.make(),
    );
  }
}
