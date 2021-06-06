import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 'floraDB'.text.color(AppColor.green).make().centered(),
    );
  }
}
