import 'dart:io';

import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/qa_controller.dart';
import 'package:floradb/model/qa/question.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:floradb/utils/file_extends.dart';

class AddQuestion extends StatelessWidget {
  final QAController _qaController = Get.find();
  final AuthController _authController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  //get user uid
  //add tag?

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                          alignment: Alignment.centerLeft,
                          child: 'Đặt câu hỏi cho cộng đồng'
                              .text
                              .size(20)
                              .make())
                      .pSymmetric(v: 8),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: 'Câu hỏi của bạn'.text.size(16).make()),
                  Gaps.vGap6,
                  TextFormField(
                    controller: _questionController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Nội dung không được để trống';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Thêm một câu hỏi cho biết vấn đề với cây trồng của bạn',
                      hintStyle:
                          TextStyle(color: AppColor.textColor.withOpacity(0.5)),
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
                    maxLines: 2,
                  ),
                  Gaps.vGap16,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: 'Mô tả vấn đề'.text.size(16).make()),
                  Gaps.vGap6,
                  TextFormField(
                    controller: _descController,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Câu hỏi không được để trống';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Mô tả các đặc trưng như thay đổi ở lá, màu rễ, bọ xít,...',
                      hintStyle:
                          TextStyle(color: AppColor.textColor.withOpacity(0.5)),
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
                    maxLines: 4,
                  )
                ],
              ),
            ).pSymmetric(h: 8),
            Gaps.vGap10,
            Obx(() => imageFilePath.value != ''
                ? SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.file(
                      File(imageFilePath.value),
                      fit: BoxFit.cover,
                    )).pSymmetric(h: 8)
                : Gaps.empty),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BrownButton(
                    label: 'Đính kèm ảnh',
                    icon: Icons.attach_file,
                    onPress: () async {
                      var imageFile = await _qaController.attachImage();

                      if (imageFile != null) {
                        imageFilePath.value = imageFile.path;
                        imageFileName.value = imageFile.name;
                      }
                    }),
                BrownButton(
                    label: 'Gửi câu hỏi',
                    icon: Icons.send,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Question question = Question(
                          id: "",
                          posterID: _authController.firestoreUser.value!.uid,
                          posterName:
                              _authController.firestoreUser.value!.userName,
                          posterAvatar:
                              _authController.firestoreUser.value!.avatarURL!,
                          attachedImage: "",
                          createdOn: DateTime.now(),
                          title: _questionController.text,
                          content: _descController.text,
                          replies: 0,
                        );
                        if (imageFilePath.value != "") {
                          _qaController
                              .addQuestionWithAttachedImage(
                                  question, imageFilePath.value)
                              .then((value) {
                            Get.back();
                            Get.snackbar('', 'Đăng câu hỏi thành công');
                          });
                        } else {
                          _qaController.addQuestion(question).then((value) {
                            Get.back();
                            Get.snackbar('', 'Đăng câu hỏi thành công');
                          });
                        }
                      }
                    }),
              ],
            ).pSymmetric(h: 8, v: 10),
            Gaps.vGap10,
          ],
        ),
      ),
    );
  }
}
