import 'package:cached_network_image/cached_network_image.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/utils/TimeFormat.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ThreadTile extends StatelessWidget {
  ThreadTile({required this.thread});

  final ForumThread thread;

  static ThreadTile buildInstance(ForumThread thread) {
    return ThreadTile(thread: thread);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        thread.posterAvatar,
        height: 50,
        width: 50,
      ),
      title: thread.title.text
          .maxLines(2)
          .minFontSize(18)
          .ellipsis
          .size(18)
          .color(AppColor.brown)
          .make(),
      subtitle: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: '${thread.poster}'
                  .text
                  .color(AppColor.textColor)
                  .size(14)
                  .make()),
          Row(
            children: [
              '${thread.replies} trả lời • '.text.size(14).make(),
              getTimeAgo(thread.createdOn.toString())!.text.size(14).make(),
            ],
          ).pOnly(top: 2),
        ],
      ),
    ).pSymmetric(h: 16, v: 4);
  }
}
