import 'dart:io';

import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/model/forum/reply.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:floradb/utils/file_extends.dart';

class AddReply extends StatelessWidget {
  final ForumController _forumController = Get.find();
  final TextEditingController _textController = TextEditingController();
  final String userName = Get.arguments[0];
  final String avatarUrl = Get.arguments[1];
  final String threadTitle = Get.arguments[2];
  final String threadID = Get.arguments[3];
  final String posterID = Get.arguments[4];
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
                child: 'Trả lời chủ đề:'
                    .text
                    .size(20)
                    .make()
                    .pSymmetric(h: 8)),
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
                      ? Gaps.empty
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
                          label: 'Thêm ảnh',
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
                          label: 'Đăng trả lời',
                          icon: Icons.reply,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              ThreadReply reply = ThreadReply(
                                posterID: posterID,
                                threadID: threadID,
                                userName: userName,
                                avatarUrl: avatarUrl,
                                createdOn: DateTime.now(),
                                content: _textController.text,
                                attachedImage: '',
                              );
                              if (imageFilePath.value != '') {
                                _forumController
                                    .addReplyWithAttachedImage(
                                        reply, imageFilePath.value)
                                    .then((value) {
                                  Get.back(result: true);
                                  Get.snackbar(
                                      '', 'Đăng trả lời thành công');
                                });
                              } else {
                                _forumController.addReply(reply).then((value) {
                                  Get.back(result: true);
                                  Get.snackbar(
                                      '', 'Đăng trả lời thành công');
                                });
                              }
                            }
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
