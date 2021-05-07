import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Sign up'.text.make(),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email Address")),
            TextFormField(
                controller: _userNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Display name")),
            TextFormField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password")),
            Row(
              children: [
                ElevatedButton(
                    child: Text("Sign up"),
                    onPressed: () async {
                      await _authController.signUp(_emailController.text,
                          _pwController.text, _userNameController.text);
                      //Get.offAllNamed(SiteNavigation.HOME);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
