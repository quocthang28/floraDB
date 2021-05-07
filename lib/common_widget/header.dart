import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageHeader extends StatelessWidget {
  HomePageHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return title.text.bold
        .size(22)
        .color(Colors.green)
        .make()
        .pSymmetric(h: 8.0)
        .pOnly(top: 8.0);
  }
}
