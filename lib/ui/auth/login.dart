import 'package:floradb/common_widget/button.dart';
import 'package:floradb/res/app_color.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:floradb/common_widget/text_with_border.dart';
import 'package:floradb/common_widget/textfield.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/gen/assets.gen.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();

  final _emailController = TextEditingController();

  final _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.background,
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(20.0),
        ),
        KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: TextWithBorder(
                        text: 'floraDB',
                        size: 90.0,
                        strokeWidth: 3,
                        fillColor: AppColor.authGreen,
                        borderColor: AppColor.brown),
                  ).pOnly(top: 130.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextWithBorder(
                        text: 'diễn đàn cung cấp dữ liệu cây cảnh',
                        size: 20.0,
                        strokeWidth: 1.5,
                        fillColor: AppColor.authGreen,
                        borderColor: AppColor.brown),
                  ),
                  Gaps.vGap50,
                  TextWithBorder(
                          text: 'Email',
                          size: 25.0,
                          strokeWidth: 2,
                          borderColor: AppColor.brown)
                      .pOnly(left: 4.0),
                  Gaps.vGap4,
                  MyTextField(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColor.brown,
                      ),
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Địa chỉ email'),
                  Gaps.vGap10,
                  TextWithBorder(
                          text: 'Mật khẩu',
                          size: 25.0,
                          strokeWidth: 2,
                          borderColor: AppColor.brown)
                      .pOnly(left: 4.0),
                  Gaps.vGap4,
                  MyTextField(
                      prefixIcon: Icon(
                        Icons.vpn_key_outlined,
                        color: AppColor.brown,
                      ),
                      inputType: TextInputType.visiblePassword,
                      controller: _pwController,
                      hintText: 'Mật khẩu',
                      isObscure: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(
                          child: 'Đăng nhập'.text.color(AppColor.brown).make(),
                          onPressed: () async {
                            await _authController.login(_emailController.text,
                                _pwController.text, context);
                          })
                    ],
                  ).p(4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextWithBorder(
                        text: 'Chưa có tài khoản? ',
                        size: 16.0,
                        strokeWidth: 1.5,
                        borderColor: Colors.black,
                      ),
                      CustomElevatedButton(
                          child: 'Đăng kí'.text.color(AppColor.brown).make(),
                          onPressed: () => Get.toNamed(SiteNavigation.SIGNUP)),
                      TextWithBorder(
                        text: ' ngay.',
                        strokeWidth: 1.5,
                        size: 16.0,
                        borderColor: Colors.black,
                      ),
                    ],
                  ).pOnly(top: 10.0),
                ],
              ).pSymmetric(h: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
