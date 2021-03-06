import 'package:cached_network_image/cached_network_image.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/gen/assets.gen.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class UserAvatar extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();

  UserAvatar({this.w, this.h, this.r});

  final double? w;
  final double? h;
  final double? r;

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
          onTap: () => _userController.changeAvatar(),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.brown, width: 2.5),
                shape: BoxShape.circle),
            child: CircleAvatar(
              radius: r,
              backgroundColor: AppColor.brown,
              child: ClipOval(
                child: CachedNetworkImage(
                  width: 70.0,
                  height: 70.0,
                  imageUrl: _authController.firestoreUser.value!.avatarURL!,
                  placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        color: AppColor.brown,
                      ),
                      child: CircularProgressIndicator().centered()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ).p(8.0),
        ));
  }
}
