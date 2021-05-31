import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/common_widget/forum/threadtile.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/model/user.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/utils/TimeFormat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ForumHome extends StatefulWidget {
  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  final ForumController _forumController = Get.find();

  Widget build(BuildContext context) {
    Widget _buildThreads(String id) {
      return StreamBuilder(
          stream: _forumController.streamForumThread(id),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Gaps.empty;
            } else {
              List<ForumThread> threads = snapshot.data!.docs
                  .map((thread) => ForumThread.fromQuerySnapshot(thread))
                  .toList();
              return ListView(
                shrinkWrap: true,
                children: threads.length < 2
                    ? threads
                        .map((ForumThread e) => ThreadTile.buildInstance(e))
                        .toList()
                    : threads
                        .sublist(0, 2)
                        .map((ForumThread e) => ThreadTile.buildInstance(e))
                        .toList(),
              );
            }
          });
    }

    Widget _buildForumCategories() {
      List<Widget> categories = [];

      _forumController.forumCategoriesLD.forEach((element) {
        categories.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: '• ${element.title}'
                      .text
                      .size(22)
                      .color(AppColor.green)
                      .make()
                      .pOnly(top: 12)),
              Row(
                children: [
                  Icon(
                    Icons.wysiwyg,
                    size: 16,
                    color: AppColor.textColor,
                  ).pOnly(right: 2),
                  'Threads: ${element.threadIDs.length}'.text.size(14).make(),
                  Gaps.hGap16,
                  Icon(
                    Icons.chat_outlined,
                    size: 16,
                    color: AppColor.textColor,
                  ).pOnly(right: 2),
                  'Posts: ${element.threadIDs.length}'.text.size(14).make(),
                ],
              ),
              Align(
                      alignment: Alignment.centerLeft,
                      child: element.threadIDs.length != 0
                          ? 'Thảo luận mới:'.text.make()
                          : 'Chưa có thảo luận.'.text.make())
                  .pOnly(top: 4, left: 16),
              _buildThreads(element.id),
              element.threadIDs.length != 0
                  ? BrownButton(
                          label: 'Xem tất cả',
                          icon: Icons.chevron_right,
                          onPress: () {})
                      .pSymmetric(h: 16)
                  : BrownButton(
                          label: 'Tạo thảo luận mới',
                          icon: Icons.add,
                          onPress: () {})
                      .pOnly(top: 10)
                      .pSymmetric(h: 16),
            ],
          ).pSymmetric(h: 8),
        );
      });
      return Column(
        children: categories,
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Diễn đàn'.text.semiBold.color(AppColor.green).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => _buildForumCategories()),
          ],
        ),
      ),
    );
  }
}
