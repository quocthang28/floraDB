import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floradb/common_widget/appbar_back_button.dart';
import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/common_widget/header.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryDetail extends StatelessWidget {
  final PlantCategoryController _plantCategoryController = Get.find();
  final PlantController _plantController = Get.find();
  final String _categoryID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    Widget _buildPlants() {
      List<Widget> plantList = [];
      _plantController.plantsLD
          .where((plant) => plant.categoryID == _categoryID)
          .forEach((plant) {
        plantList.add(Container(
          child: plant.name.text.make(),
        ));
      });
      return Container(
        child: Column(
          children: plantList,
        ),
      );
    }

    Widget _buildPlantList() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Header('Thuộc danh mục này ', haveSeemore: true),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          Obx(() => _buildPlants()),
          BrownButton(
            label: 'Thêm cây vào danh mục',
            icon: Icons.add,
            onPress: () {},
          ),
        ],
      ).p(8.0);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context), child: AppBackButton()),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColor.green),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  height: 220,
                  autoPlay: true,
                ),
                items: _plantCategoryController.plantCategoriesLD
                    .firstWhere((element) => element.id == _categoryID)
                    .imageURLs
                    .map((imageURL) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CachedNetworkImage(
                        height: 220,
                        imageUrl: imageURL,
                        placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: CircularProgressIndicator().centered()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              ),
              '${_plantCategoryController.plantCategoriesLD.firstWhere((element) => element.id == _categoryID).vietnameseName}'
                  .text
                  .semiBold
                  .size(30.0)
                  .color(AppColor.green)
                  .make()
                  .pOnly(left: 8.0)
                  .p(8.0),
              '\t\t${_plantCategoryController.plantCategoriesLD.firstWhere((element) => element.id == _categoryID).shortDesc}'
                  .text
                  .size(16.0)
                  .color(AppColor.textColor)
                  .align(TextAlign.justify)
                  .make()
                  .pSymmetric(h: 8.0),
              _buildPlantList(),
            ],
          ),
        ),
      ),
    );
  }
}
