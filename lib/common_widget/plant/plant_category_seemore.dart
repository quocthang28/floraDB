import 'package:floradb/res/app_color.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategorySeeMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(SiteNavigation.ALLCATEGORIES),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                'Xem tất cả'.text.color(AppColor.brown).size(15.0).make(),
                Icon(
                  Icons.chevron_right,
                  color: AppColor.brown,
                ),
              ],
            ),
          ],
        ),
      ).pOnly(top: 4.0),
    );
  }
}
