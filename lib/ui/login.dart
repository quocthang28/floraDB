import 'package:floradb/common_widget/button.dart';
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
                        fillColor: Colors.lightGreen.shade100,
                        borderColor: Colors.brown.shade400),
                  ).pOnly(top: 130.0),
                  Align(
                    alignment: Alignment.center,
                    child: TextWithBorder(
                        text: 'plants and flowers database',
                        size: 25.0,
                        strokeWidth: 1.5,
                        fillColor: Colors.lightGreen.shade100,
                        borderColor: Colors.brown.shade400),
                  ),
                  Gaps.vGap50,
                  TextWithBorder(
                          text: 'Email',
                          size: 25.0,
                          strokeWidth: 2,
                          borderColor: Colors.brown)
                      .pOnly(left: 4.0),
                  Gaps.vGap4,
                  MyTextField(
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Email Address'),
                  Gaps.vGap10,
                  TextWithBorder(
                          text: 'Password',
                          size: 25.0,
                          strokeWidth: 2,
                          borderColor: Colors.brown)
                      .pOnly(left: 4.0),
                  Gaps.vGap4,
                  MyTextField(
                      inputType: TextInputType.visiblePassword,
                      controller: _pwController,
                      hintText: 'Password',
                      isObscure: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomElevatedButton(
                          child:
                              'Login'.text.color(Colors.brown.shade400).make(),
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
                        text: 'Don\'t have an account? ',
                        size: 16.0,
                        borderColor: Colors.black,
                      ),
                      // GestureDetector(
                      //   onTap: () => Get.toNamed(SiteNavigation.SIGNUP),
                      //   child: TextWithBorder(
                      //       text: 'Sign Up',
                      //       size: 18.0,
                      //       fillColor: Colors.green,
                      //       borderColor: Colors.transparent),
                      // ),
                      CustomElevatedButton(
                          child: 'Sign Up'
                              .text
                              .color(Colors.brown.shade400)
                              .make(),
                          onPressed: () => Get.toNamed(SiteNavigation.SIGNUP)),
                      TextWithBorder(
                        text: ' now.',
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
