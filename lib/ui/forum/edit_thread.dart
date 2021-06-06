import 'dart:io';

import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:floradb/utils/file_extends.dart';

class EditThread extends StatelessWidget {
  final ForumController _forumController = Get.find();
  final String categoryID = Get.arguments[0];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController =
      TextEditingController(text: Get.arguments[1]);
  final TextEditingController _contentController =
      TextEditingController(text: Get.arguments[2]);
  final String threadID = Get.arguments[3];
  final String imageUrl = Get.arguments[4];
  final imageFileName = ''.obs;
  final imageFilePath = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: 'Sửa thảo luận'.text.size(20).make().pSymmetric(h: 8),
            ),
            Gaps.vGap20,
            Align(
              alignment: Alignment.centerLeft,
              child: 'Tiêu đề:'.text.size(16).make().pSymmetric(h: 8),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Tiêu đề không được để trống';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(top: 6, bottom: 6, left: 6, right: 6),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                    ),
                  ).pSymmetric(h: 8, v: 4),
                  Gaps.vGap10,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: 'Nội dung:'.text.size(16).make().pSymmetric(h: 8),
                  ),
                  TextFormField(
                    controller: _contentController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Nội dung không được để trống';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.green, width: 1),
                      ),
                    ),
                    maxLines: 10,
                  ).pSymmetric(h: 8, v: 4),
                  Obx(() => imageFileName.value == ''
                      ? imageUrl == ""
                          ? Gaps.empty
                          : Image.network(
                              imageUrl,
                              height: 120,
                              width: 120,
                            ).pOnly(left: 8)
                      : Image.file(
                          File(imageFilePath.value),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ).pOnly(top: 8, left: 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BrownButton(
                          label: 'Sửa ảnh',
                          icon: Icons.attach_file,
                          onPress: () async {
                            var imageFile =
                                await _forumController.attachImage();

                            if (imageFile != null) {
                              imageFilePath.value = imageFile.path;
                              imageFileName.value = imageFile.name;
                            }
                          }),
                      BrownButton(
                          label: 'Sửa thảo luận',
                          icon: Icons.edit,
                          onPress: () async {
                            _forumController
                                .editThread(
                                    threadID,
                                    _titleController.text,
                                    _contentController.text,
                                    imageUrl,
                                    imageFilePath.value)
                                .then((value) {
                              Get.back(result: true);
                              Get.snackbar('', 'Sửa thảo luận thành công');
                            });
                          }).pSymmetric(v: 15),
                    ],
                  ).pSymmetric(h: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
