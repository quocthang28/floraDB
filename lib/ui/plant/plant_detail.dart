import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantDetail extends StatelessWidget {
  final PlantController _plantController = Get.find();
  final String plantID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title:
            '${_plantController.plantsLD.firstWhere((element) => element.id == plantID).name}'
                .text
                .color(AppColor.green)
                .make(),
      ),
    );
  }
}
