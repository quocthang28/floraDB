import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/common_widget/forum/thread_tile.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ForumHome extends StatefulWidget {
  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome>
    with AutomaticKeepAliveClientMixin<ForumHome> {
  final ForumController _forumController = Get.find();

  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    super.build(context);
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
                physics: NeverScrollableScrollPhysics(),
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
                  child: '??? ${element.title}'
                      .text
                      .size(22)
                      .color(AppColor.green)
                      .make()
                      .pOnly(top: 12, left: 8)),
              Row(
                children: [
                  Icon(
                    Icons.wysiwyg,
                    size: 16,
                    color: AppColor.textColor,
                  ).pOnly(right: 2),
                  'Threads: ${element.threadIDs.length}'.text.size(14).make(),
                ],
              ).pOnly(left: 8),
              Align(
                      alignment: Alignment.centerLeft,
                      child: element.threadIDs.length != 0
                          ? 'Tha??o lu????n m????i:'.text.make()
                          : 'Ch??a co?? tha??o lu????n.'.text.make())
                  .pOnly(top: 4, left: 16),
              _buildThreads(element.id),
              element.threadIDs.length != 0
                  ? BrownButton(
                          label: 'Xem t????t ca??',
                          icon: Icons.chevron_right,
                          onPress: () => Get.toNamed(SiteNavigation.ALLTHREADS,
                              arguments: [element.id, element.title]))
                      .pSymmetric(h: 16)
                  : BrownButton(
                          label: 'Ta??o tha??o lu????n m????i',
                          icon: Icons.add,
                          onPress: () => Get.toNamed(SiteNavigation.ADDTHREAD,
                              arguments: element.id))
                      .pOnly(top: 10)
                      .pSymmetric(h: 16),
              Divider(
                height: 12,
                thickness: 10,
              ).pOnly(top: 10),
            ],
          ),
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
        title: 'Di????n ??a??n'.text.semiBold.color(AppColor.green).make(),
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
