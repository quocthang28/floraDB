import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:floradb/common_widget/appbar_back_button.dart';
import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/common_widget/header.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:floradb/model/plant/plant_category.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategoryDetail extends StatelessWidget {
  final PlantCategoryController _plantCategoryController = Get.find();
  final String _categoryID = Get.arguments;

  @override
  Widget build(BuildContext context) {
    PlantCategory _category = _plantCategoryController.plantCategoriesLD
        .firstWhere((element) => element.id == _categoryID);

    Widget _buildPlantList() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Header('Danh sách cây cảnh thuộc danh mục', haveSeemore: false),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
          'aaaaaaa'.text.make(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  '${_plantCategoryController.plantCategoriesLD.firstWhere((element) => element.id == _categoryID).vietnameseName}'
                      .text
                      .semiBold
                      .size(28.0)
                      .color(AppColor.green)
                      .make()
                      .pOnly(left: 8.0),
                  BrownButton(
                      label: 'Thêm cây vào\ndanh mục này',
                      icon: Icons.add,
                      onPress: () {}),
                ],
              ).pSymmetric(h: 8.0, v: 8.0),
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
