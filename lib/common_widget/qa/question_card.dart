import 'package:cached_network_image/cached_network_image.dart';
import 'package:floradb/common_widget/full_screen_image.dart';
import 'package:floradb/model/qa/question.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class QuestionCard extends StatelessWidget {
  QuestionCard(this.question);

  final Question question;

  static QuestionCard buildInstance(Question question) {
    return QuestionCard(question);
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          question.attachedImage != ""
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(
                        imageUrl: question.attachedImage,
                        tag: "generate_a_unique_tag",
                      );
                    }));
                  },
                  child: Hero(
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 180,
                      imageUrl: question.attachedImage,
                      placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: CircularProgressIndicator().centered()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    tag: "generate_a_unique_tag",
                  ),
                )
              : Gaps.empty,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Get.toNamed(SiteNavigation.QUESTIONDETAIL,
                arguments: [question.id, question.title]),
            child: Column(
              children: <Widget>[
                ListTile(
                  visualDensity: VisualDensity.compact,
                  title: question.posterName.text.make(),
                  leading: Image.network(
                    question.posterAvatar,
                    height: 40,
                    width: 40,
                  ),
                  subtitle: timeago
                      .format(question.createdOn, locale: 'vi')
                      .text
                      .make(),
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: question.title.text.size(16).semiBold.make()),
                    Gaps.vGap4,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: question.content.text
                            .maxLines(3)
                            .ellipsis
                            .minFontSize(15)
                            .size(15)
                            .color(AppColor.textColor)
                            .make()),
                  ],
                ).pSymmetric(h: 16),
                Align(
                        alignment: Alignment.bottomRight,
                        child: '${question.replies} trả lời'
                            .text
                            .size(12)
                            .make())
                    .p(8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
