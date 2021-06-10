import 'package:floradb/common_widget/text_with_border.dart';
import 'package:floradb/common_widget/user_avatar.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/gen/assets.gen.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Account extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    var user = _authController.firestoreUser.value!;
    String level = _authController.isAd.value ? 'Admin' : 'Thành viên';
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Tài khoản'.text.semiBold.color(AppColor.green).make(),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Assets.images.avatarbackground.image(),
              Positioned(
                  top: 70.0, child: UserAvatar(w: 100.0, h: 100.0, r: 30.0)),
              Positioned(
                  top: 90,
                  left: 80,
                  child: TextWithBorder(
                    text: user.userName,
                    size: 22.0,
                    borderColor: Colors.black,
                  )),
              Positioned(
                  top: 120,
                  left: 80,
                  child: TextWithBorder(
                    text: 'Cấp độ: $level',
                    size: 16.0,
                    borderColor: Colors.black,
                  )),
            ],
          ),
          DrawerAction(
              icon: Icons.account_circle_outlined,
              title: 'Đổi ảnh đại diện',
              onTap: () => _userController.changeAvatar()),
          Divider(height: 1, thickness: 1),
          DrawerAction(
              icon: Icons.info_outline,
              title: 'Thông tin ứng dụng',
              onTap: () {}),
          Divider(height: 1, thickness: 1),
          DrawerAction(
              icon: Icons.logout,
              title: 'Đăng xuất',
              onTap: () => _authController.signOut()),
        ],
      ),
    );
  }
}
//todo: list thread, question started by user

class DrawerAction extends StatelessWidget {
  DrawerAction({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Icon(icon, color: AppColor.brown),
      title: title.text.size(18.0).color(AppColor.brown).make(),
    );
  }
}
