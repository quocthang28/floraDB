import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PlantCategorySeeMore extends StatelessWidget {
  //todo: add navigation to all categories page
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.chevron_right,
            color: Colors.green,
            size: 26.0,
          ),
          'Xem tất cả'.text.color(Colors.green).size(18.0).make(),
        ],
      ),
    ).pOnly(top: 4.0);
  }
}
