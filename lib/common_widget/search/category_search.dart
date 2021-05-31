import 'package:floradb/common_widget/plant/plant_category_card.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategorySearch extends SearchDelegate<PlantCategoryCard> {
  CategorySearch({
    String hintText = "Nhập tên danh mục",
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  final PlantCategoryController _plantCategoryController = Get.find();

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
      onPressed: () => Get.offAllNamed(SiteNavigation.HOME),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Widget> cards = [];
    _plantCategoryController.plantCategoriesLD
        .where((element) => element.vietnameseName
            .trim()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .forEach((element) {
      cards.add(PlantCategoryCard.buildInstance(element));
    });
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

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Widget> cards = [];
    _plantCategoryController.plantCategoriesLD
        .where((element) =>
            element.vietnameseName.toLowerCase().contains(query.toLowerCase()))
        //   .where((element) {
        // print(utf8.decode(element.vietnameseName));
        // print(utf8.decode(query));
        // return element.vietnameseName.toLowerCase().contains(query.toLowerCase());
        //})
        .forEach((element) {
      cards.add(PlantCategoryCard.buildInstance(element));
    });
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
}
