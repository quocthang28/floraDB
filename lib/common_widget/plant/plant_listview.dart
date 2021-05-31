import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/model/plant/plant.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class PlantListView extends StatelessWidget {
  PlantListView({required this.categoryID});

  final PlantController _plantController = Get.find();
  final String categoryID;

  @override
  Widget build(BuildContext context) {
    Widget _buildPlantList() {
      List<Plant> plantList = [];
      _plantController.plantsByCategoryLD.forEach((plant) {
        plantList.add(plant);
      });
      return ListView.separated(
        itemCount: plantList.length,
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: AppColor.textColor,
        ).pSymmetric(h: 16.0),
        itemBuilder: (context, i) => ListTile(
          onTap: () => Get.toNamed(SiteNavigation.PLANTDETAIL,
              arguments: plantList[i].id),
          visualDensity: VisualDensity.compact,
          title: plantList[i].name.text.color(AppColor.brown).make(),
          subtitle: plantList[i].scientificName.text.make(),
          trailing: Icon(Icons.chevron_right, color: AppColor.brown),
        ),
      );
    }

    return _plantController.plantsByCategoryLD.length == 0
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              'Danh mục hiện chưa có cây cảnh.'.text.make(),
              //TODO: ADD BUTTON FUNCTION
              Gaps.vGap16,
              BrownButton(
                  label: 'Thêm cây vào danh mục',
                  icon: Icons.add,
                  onPress: () {}),
            ],
          ))
        : Obx(() => _buildPlantList());
  }
}
