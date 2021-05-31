import 'package:floradb/res/app_color.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class QandA extends StatefulWidget {
  @override
  _QAState createState() => _QAState();
}

class _QAState extends State<QandA> with AutomaticKeepAliveClientMixin<QandA> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Hỏi đáp'.text.semiBold.color(AppColor.green).make(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.lightBrown,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: 'questions and answers'.text.make(),
      ),
    );
  }
}
