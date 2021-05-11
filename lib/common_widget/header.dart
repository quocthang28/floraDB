import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Header extends StatelessWidget {
  Header(this.title, {required this.haveSeemore});

  final String title;
  final bool haveSeemore;

  @override
  Widget build(BuildContext context) {
    return haveSeemore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              title.text.semiBold.size(20).color(AppColor.green).make(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  'Xem tất cả'.text.size(15.0).color(AppColor.brown).make(),
                  Icon(Icons.chevron_right, color: AppColor.brown)
                ],
              ),
            ],
          ).p(4.0).pSymmetric(h: 4.0)
        : title.text.semiBold
            .size(20)
            .color(AppColor.green)
            .make()
            .p(4.0)
            .pSymmetric(h: 4.0);
  }
}
