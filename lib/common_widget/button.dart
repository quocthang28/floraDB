import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColor.authGreen),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
