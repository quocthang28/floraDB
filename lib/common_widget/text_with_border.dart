import 'package:flutter/material.dart';

class TextWithBorder extends StatelessWidget {
  TextWithBorder(
      {required this.text,
      required this.size,
      required this.borderColor,
      this.fillColor,
      this.strokeWidth,
      this.fontWeight});

  final String text;
  final double size;
  final Color borderColor;
  final Color? fillColor;
  final double? strokeWidth;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //border
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight ?? FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth ?? 1
              ..color = borderColor,
          ),
        ),
        //fill
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: fillColor ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
