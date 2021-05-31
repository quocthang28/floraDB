import 'package:floradb/common_widget/plant/plant_listview.dart';
import 'package:floradb/common_widget/search/plant_search.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AllPlant extends StatelessWidget {
  AllPlant({required this.categoryID, required this.categoryName});

  final String categoryID;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: categoryName.text.color(AppColor.green).make(),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: AppColor.green,
            onPressed: () =>
                showSearch(context: context, delegate: PlantSearch(categoryID)),
          )
        ],
      ),
      body: PlantListView(categoryID: categoryID),
    );
  }
}
