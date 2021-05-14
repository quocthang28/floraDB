import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/ui/home/home_drawer.dart';
import 'package:floradb/common_widget/header.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/common_widget/plant/plant_categories_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'floraDB'.text.semiBold.color(AppColor.green).make(),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: Header('Danh mục cây cảnh', haveSeemore: false),
            ),
            PlantCategoryGrid(haveSeeMore: true),
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: Header('Chủ đề thảo luận mới', haveSeemore: true),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Header('Hỏi đáp', haveSeemore: true),
            ),
            TextButton(
                onPressed: () => _authController.signOut(),
                child: 'sign out'.text.make()),
          ],
        ),
      ),
    );
  }
}
