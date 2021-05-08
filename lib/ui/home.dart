import 'package:floradb/common_widget/app_drawer.dart';
import 'package:floradb/common_widget/header.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/ui/component/home/plant_categories_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        title: 'floraDB'.text.semiBold.color(Colors.green).make(),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: HomePageHeader('Phân loại cây cảnh', false),
            ),
            PlantCategoryGrid(),
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: HomePageHeader('Chủ đề thảo luận', true),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: HomePageHeader('Hỏi đáp', true),
            ),
          ],
        ),
      ),
    );
  }
}
