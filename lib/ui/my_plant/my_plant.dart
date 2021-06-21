import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MyPlant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Cây cảnh của bạn'.text.semiBold.color(AppColor.green).make(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.lightBrown,
        onPressed: null,
        icon: Icon(Icons.add),
        label: 'Thêm'.text.make(),
      ),
      body: 'my plant'.text.make(),
    );
  }
}
