import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/forum/thread_tile.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AllThreads extends StatelessWidget {
  final ForumController _forumController = Get.find();
  final String categoryID = Get.arguments[0];
  final String categoryName = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: categoryName.text.semiBold.color(AppColor.green).make(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed(SiteNavigation.ADDTHREAD, arguments: categoryID),
        backgroundColor: AppColor.lightBrown,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: _forumController.streamForumThread(categoryID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<ForumThread> threads = snapshot.data!.docs
                .map((thread) => ForumThread.fromQuerySnapshot(thread))
                .toList();
            return ListView.separated(
              itemCount: threads.length,
              itemBuilder: (context, index) =>
                  ThreadTile.buildInstance(threads[index]),
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
              ),
            );
          } else
            return Gaps.empty;
        },
      ).pOnly(top: 6),
    );
  }
}
