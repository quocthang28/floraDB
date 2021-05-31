import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {required this.controller,
      required this.inputType,
      required this.hintText,
      this.isObscure,
      this.prefixIcon});

  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final bool? isObscure;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      //todo: add validator
      keyboardType: inputType,
      style: TextStyle(fontSize: 20.0),
      controller: controller,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
          prefixIcon: prefixIcon ?? null,
          hintStyle: TextStyle(
            fontSize: 15.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColor.brown, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColor.brown, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: AppColor.brown, width: 2.0),
          ),
          contentPadding: EdgeInsets.all(10.0),
          isDense: true,
          filled: true,
          hintText: hintText,
          fillColor: Colors.white,
          focusColor: AppColor.green),
    ).pSymmetric(h: 4.0);
  }
}
