import 'package:floradb/common_widget/header.dart';
import 'package:floradb/common_widget/plant/plant_category_card.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/model/plant/plant_category.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/ui/component/home/plant_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find(); // check admin status

  @override
  Widget build(BuildContext context) {
    var _isAdmin = _authController.isAd.value;
    UserModel user = _authController.firestoreUser.value!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: '${user.userName}'.text.make(),
        actions: [
          TextButton(
              onPressed: () => _authController.signOut(),
              child: 'logout'.text.make())
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: HomePageHeader('Các họ cây cảnh phổ biến')),
            PlantCategoryGrid(),
          ],
        ),
      ),
    );
  }
}
