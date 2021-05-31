import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Header extends StatelessWidget {
  Header(this.title, {required this.haveSeemore, this.count, this.onTap});

  final String title;
  final bool haveSeemore;
  final int? count;
  final VoidCallback? onTap;

  //todo: sticky header
  @override
  Widget build(BuildContext context) {
    return haveSeemore
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  title.text.semiBold.size(20).color(AppColor.green).make(),
                  count != null
                      ? ' ($count)'
                          .text
                          .size(16)
                          .color(AppColor.textColor)
                          .make()
                      : Gaps.empty,
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    'Xem tất cả'.text.size(15.0).color(AppColor.brown).make(),
                    Icon(Icons.chevron_right, color: AppColor.brown)
                  ],
                ),
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
