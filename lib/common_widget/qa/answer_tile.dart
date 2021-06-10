import 'package:floradb/model/qa/answer.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class AnswerTile extends StatelessWidget {
  AnswerTile(this.answer);

  final Answer answer;

  static AnswerTile buildInstance(Answer answer) {
    return AnswerTile(answer);
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    Widget _buildLikes() {
      //TODO: ADD like function
      return Row(
        children: <Widget>[
          Icon(Icons.thumb_up_alt_outlined, color: AppColor.brown),
          ' ${answer.likes}'.text.make(),
          Gaps.hGap16,
          Icon(Icons.thumb_down_alt_outlined, color: AppColor.brown),
          ' ${answer.dislikes}'.text.make()
        ],
      ).p(10).pOnly(left: 10);
    }

    return Column(
      children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          leading: Image.network(
            answer.posterAvatar,
            width: 25,
            height: 25,
          ),
          minLeadingWidth: 15,
          title: answer.posterName.text.make(),
          subtitle: timeago.format(answer.createdOn, locale: 'vi').text.make(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: answer.content.text
              .color(AppColor.textColor)
              .make()
              .pSymmetric(h: 20),
        ),
        _buildLikes(),
      ],
    );
  }
}
