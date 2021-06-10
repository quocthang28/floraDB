import 'package:floradb/common_widget/qa/answer_tile.dart';
import 'package:floradb/common_widget/qa/question_card.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/qa_controller.dart';
import 'package:floradb/model/qa/answer.dart';
import 'package:floradb/model/qa/question.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionDetail extends StatelessWidget {
  final QAController _qaController = Get.find();
  final AuthController _authController = Get.find();
  final String questionID = Get.arguments[0];
  final String questionTitle = Get.arguments[1];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final isDisabled = true.obs;

  @override
  Widget build(BuildContext context) {
    Widget _buildAnswers() {
      return StreamBuilder<List<Answer>>(
        stream: _qaController.streamAnswers(questionID),
        builder: (context, AsyncSnapshot<List<Answer>> snapshot) {
          if (!snapshot.hasData) {
            return Gaps.empty;
          } else if (snapshot.hasData) {
            if (snapshot.data!.length == 0) {
              return 'Chưa có trả lời.'.text.make().p(40);
            } else {
              List<AnswerTile> answersList = snapshot.data!
                  .map((e) => AnswerTile.buildInstance(e))
                  .toList();
              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: answersList.length,
                itemBuilder: (context, index) => answersList[index],
                separatorBuilder: (context, index) => Divider(
                  height: 4,
                  thickness: 4,
                ),
              );
            }
          } else
            return 'Chưa có trả lời.'.text.make().p(40);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title:
            questionTitle.text.semiBold.ellipsis.color(AppColor.green).make(),
      ),
      body: KeyboardDismissOnTap(
        child: Stack(
          children: [
            StreamBuilder<Question>(
              stream: _qaController.streamQuestion(questionID),
              builder: (context, AsyncSnapshot<Question> snapshot) {
                if (!snapshot.hasData) {
                  return Gaps.empty;
                }
                Question question = snapshot.data!;
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      QuestionCard.buildInstance(question),
                      Divider(
                        height: 12,
                        thickness: 10,
                      ),
                      _buildAnswers(),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                child: Row(
                  children: [
                    Gaps.hGap4,
                    Image.network(
                      _authController.firestoreUser.value!.avatarURL!,
                      width: 25,
                      height: 25,
                    ),
                    Gaps.hGap8,
                    TextField(
                      controller: _textEditingController,
                      maxLines: null,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        hintText: 'Viết câu trả lời của bạn',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.green, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.brown, width: 0.5),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColor.green, width: 0.5),
                        ),
                      ),
                      onChanged: (value) => isDisabled.value =
                          _textEditingController.text.isEmptyOrNull,
                    ).expand(),
                    Obx(
                      () => IconButton(
                        onPressed: isDisabled.value
                            ? null
                            : () {
                                Answer answer = Answer(
                                    questionID: questionID,
                                    posterID: _authController
                                        .firestoreUser.value!.uid,
                                    posterName: _authController
                                        .firestoreUser.value!.userName,
                                    posterAvatar: _authController
                                        .firestoreUser.value!.avatarURL!,
                                    createdOn: DateTime.now(),
                                    likes: 0,
                                    dislikes: 0,
                                    content: _textEditingController.text);
                                _qaController
                                    .addAnswer(answer, questionID)
                                    .then((value) {
                                  FocusScope.of(context).unfocus();
                                  _scrollController.animToBottom();
                                  _textEditingController.clear();
                                });
                              },
                        disabledColor: Colors.grey,
                        icon: Icon(
                          Icons.send,
                          color:
                              isDisabled.value ? Colors.grey : AppColor.brown,
                        ),
                      ),
                    ),
                  ],
                ).p(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
