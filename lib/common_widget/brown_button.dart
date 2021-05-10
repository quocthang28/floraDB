import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BrownButton extends StatelessWidget {
  BrownButton({required this.label, required this.icon, required this.onPress});

  final String label;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPress,
      icon: Icon(
        icon,
        color: AppColor.brown,
      ),
      label: label.text.color(AppColor.brown).align(TextAlign.center).make(),
      style: TextButton.styleFrom(
        visualDensity: VisualDensity.comfortable,
        backgroundColor: AppColor.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.7,
              color: AppColor.brown,
            ),
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
