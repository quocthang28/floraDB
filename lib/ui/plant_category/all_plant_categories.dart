import 'package:floradb/common_widget/search/category_search.dart';
import 'package:floradb/res/app_color.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:floradb/common_widget/plant/plant_categories_grid.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Danh mục cây cảnh'.text.color(AppColor.green).make(),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: AppColor.green,
            onPressed: () =>
                showSearch(context: context, delegate: CategorySearch()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: PlantCategoryGrid(
          haveSeeMore: false,
        ),
      ),
    );
  }
}
