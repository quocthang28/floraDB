import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePageHeader extends StatelessWidget {
  HomePageHeader(this.title, this.haveSeemore);

  final String title;
  final bool haveSeemore;

  @override
  Widget build(BuildContext context) {
    return haveSeemore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              title.text.bold.size(22).color(Colors.green).make(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  'Xem tất cả'.text.size(18.0).color(Colors.green).make(),
                  Icon(Icons.chevron_right, color: Colors.green),
                ],
              ),
            ],
          ).p(4.0).pSymmetric(h: 4.0)
        : title.text.bold
            .size(22)
            .color(Colors.green)
            .make()
            .p(4.0)
            .pSymmetric(h: 4.0);
  }
}
