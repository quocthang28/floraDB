import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/qa/question_card.dart';
import 'package:floradb/controller/qa_controller.dart';
import 'package:floradb/model/qa/question.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class QandA extends StatefulWidget {
  @override
  _QAState createState() => _QAState();
}

class _QAState extends State<QandA> with AutomaticKeepAliveClientMixin<QandA> {
  QAController _qaController = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xFFF1EEEE),
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Hỏi đáp'.text.semiBold.color(AppColor.green).make(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(SiteNavigation.ADDQUESTION),
        backgroundColor: AppColor.lightBrown,
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: _qaController.streamQuestions(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Question> questions = snapshot.data!.docs
                .map((question) => Question.fromQuerySnapshot(question))
                .toList();
            List<QuestionCard> questionCards =
                questions.map((e) => QuestionCard.buildInstance(e)).toList();
            return ListView.builder(
                itemCount: questions.length + 1,
                itemBuilder: (context, index) => index == questions.length
                    ? '●'
                        .text
                        .color(AppColor.textColor.withOpacity(0.2))
                        .size(40)
                        .make()
                        .centered()
                        .pOnly(bottom: 20)
                    : questionCards[index].p(2).pSymmetric(v: 6));
          } else
            return Gaps.empty;
        },
      ),
    );
  }
}
