import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          decoration: BoxDecoration(color: Colors.grey[600]!.withOpacity(0.4)),
          child: Icon(Icons.arrow_back, color: Colors.white)),
    ).p(4.0);
  }
}
