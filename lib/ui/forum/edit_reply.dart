import 'dart:io';

import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:floradb/utils/file_extends.dart';

class EditReply extends StatelessWidget {
  final ForumController _forumController = Get.find();
  final TextEditingController _textController =
      TextEditingController(text: Get.arguments[2]);
  final String threadTitle = Get.arguments[0];
  final String replyID = Get.arguments[1];
  final String imageUrl = Get.arguments[3];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                child: 'Sửa trả lời:'.text.size(20).make().pSymmetric(h: 8)),
            Align(
              alignment: Alignment.centerLeft,
              child: threadTitle.text
                  .size(20)
                  .color(AppColor.green)
                  .make()
                  .pSymmetric(h: 8),
            ),
            Divider(
              thickness: 1,
              height: 1,
            ).pSymmetric(v: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: 'Nội dung:'.text.size(16).make().pSymmetric(h: 8),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _textController,
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
                          label: 'Sửa trả lời',
                          icon: Icons.edit,
                          onPress: () async {
                            // if (_formKey.currentState!.validate()) {
                            //   if (imageFilePath.value != '') {
                            //   } else {}
                            // }
                            _forumController
                                .editReply(_textController.text, replyID,
                                    imageUrl, imageFilePath.value)
                                .then((value) {
                              Get.back(result: true);
                              Get.snackbar('', 'Sửa trả lời thành công');
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
//todo: edit attached image (or delete it)

// var userName =
//     _authController.firestoreUser.value!.userName;
// var avatarUrl =
// _authController.firestoreUser.value!.avatarURL!;
// ThreadReply reply = ThreadReply(
//     threadID: thread.id,
//     userName: userName,
//     avatarUrl: avatarUrl,
//     createdOn: DateTime.now(),
//     content: 'test reply');
// _forumController
//     .addReply(reply)
// .then((value) => _scrollController.animToBottom());
