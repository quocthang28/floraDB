import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';

showLoadingIndicator(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.green)),
        ),
      );
    },
  );
}
