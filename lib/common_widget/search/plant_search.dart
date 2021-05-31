import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/model/plant/plant.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantSearch extends SearchDelegate {
  PlantSearch(
    this.categoryID, {
    String hintText = "Nhập tên cây",
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  final PlantController _plantController = Get.find();
  final String categoryID;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        color: AppColor.green,
        onPressed: () => Navigator.pop(context),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: AppColor.green,
      onPressed: () {
        var nav = Navigator.of(context);
        nav.pop();
        nav.pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Plant> plantList = [];
    _plantController.plantsByCategoryLD
        .where((plant) =>
            plant.categoryID == categoryID &&
            plant.name.toLowerCase().contains(query.toLowerCase()))
        .forEach((plant) {
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
        onTap: () =>
            Get.toNamed(SiteNavigation.PLANTDETAIL, arguments: plantList[i].id),
        visualDensity: VisualDensity.compact,
        title: plantList[i].name.text.color(AppColor.brown).make(),
        subtitle: plantList[i].scientificName.text.make(),
        trailing: Icon(Icons.chevron_right, color: AppColor.brown),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Plant> plantList = [];
    _plantController.plantsByCategoryLD
        .where((plant) =>
            plant.categoryID == categoryID &&
            plant.name.toLowerCase().contains(query.toLowerCase()))
        .forEach((plant) {
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
        onTap: () =>
            Get.toNamed(SiteNavigation.PLANTDETAIL, arguments: plantList[i].id),
        visualDensity: VisualDensity.compact,
        title: plantList[i].name.text.color(AppColor.brown).make(),
        subtitle: plantList[i].scientificName.text.make(),
        trailing: Icon(Icons.chevron_right, color: AppColor.brown),
      ),
    );
  }
}
