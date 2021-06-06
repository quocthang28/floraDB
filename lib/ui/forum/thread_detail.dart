import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/brown_button.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/model/forum/reply.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/site_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThreadDetail extends StatelessWidget {
  final ForumController _forumController = Get.find();
  final AuthController _authController = Get.find();
  final ForumThread thread = Get.arguments[0];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Widget _buildThread() {
      return Column(
        children: <Widget>[
          Align(
                  alignment: Alignment.centerLeft,
                  child:
                      thread.title.text.color(AppColor.green).size(25).make())
              .pOnly(left: 8),
          Stack(
            children: [
              ListTile(
                visualDensity: VisualDensity.compact,
                trailing: '#1'.text.make(),
                leading: Image.network(
                  thread.posterAvatar,
                  width: 40,
                  height: 40,
                ),
                title: thread.poster.text.make(),
                subtitle: Row(
                  children: [
                    '${thread.replies} trả lời • '.text.size(14).make(),
                    //getTimeAgo(thread.createdOn.toString())!.text.size(14).make(),
                    timeago.format(thread.createdOn, locale: "vi").text.make(),
                  ],
                ).pOnly(top: 2),
              ),
              _authController.firestoreUser.value!.userName == thread.poster
                  ? Positioned(
                      bottom: 35,
                      right: 2,
                      child: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_horiz,
                          color: AppColor.textColor,
                        ),
                        onSelected: (value) {
                          value == 'Sửa'
                              ? Get.toNamed(SiteNavigation.EDITTHREAD,
                                  arguments: [
                                      thread.categoryID,
                                      thread.title,
                                      thread.content,
                                      thread.id,
                                      thread.attachedImage
                                    ])
                              : _forumController
                                  .deleteThread(thread.id, thread.categoryID,
                                      thread.attachedImage)
                                  .then((value) {
                                  Get.back();
                                  Get.snackbar(
                                      '', 'Xóa thảo luận thành công');
                                });
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Sửa', 'Xóa'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice,
                                  style: TextStyle(color: AppColor.brown)),
                            );
                          }).toList();
                        },
                      ),
                    )
                  : Gaps.empty,
            ],
          ),
          Divider(
            height: 1,
            thickness: 1,
          ).pOnly(bottom: 6).pSymmetric(h: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: thread.content.text
                .size(16.0)
                .color(AppColor.textColor)
                .align(TextAlign.justify)
                .make()
                .pSymmetric(h: 8.0),
          ),
          thread.attachedImage.isNotEmpty
              ? Image.network(
                  thread.attachedImage,
                  width: double.infinity,
                  height: 200,
                ).p(8)
              : Gaps.empty,
          Divider(
            height: 12,
            thickness: 10,
          ).pSymmetric(v: 8),
        ],
      );
    }

    Widget _buildReplies() {
      return StreamBuilder(
          stream: _forumController.streamThreadReplies(thread.id),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<ThreadReply> replies = snapshot.data!.docs
                  .map((reply) => ThreadReply.fromQuerySnapshot(reply))
                  .toList();
              return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: replies.length,
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        ListTile(
                          visualDensity: VisualDensity.compact,
                          trailing: '#${index + 2}'
                              .text
                              .color(AppColor.textColor)
                              .make(),
                          leading: Image.network(
                            replies[index].avatarUrl,
                            width: 40,
                            height: 40,
                          ),
                          title: replies[index].userName.text.make(),
                          subtitle: timeago
                              .format(replies[index].createdOn, locale: "vi")
                              .text
                              .make(),
                        ),
                        _authController.firestoreUser.value!.uid ==
                                replies[index].posterID
                            ? Positioned(
                                bottom: 35,
                                right: 2,
                                child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: AppColor.textColor,
                                  ),
                                  onSelected: (value) {
                                    value == 'Sửa'
                                        ? Get.toNamed(SiteNavigation.EDITREPLY,
                                            arguments: [
                                                thread.title,
                                                replies[index].id,
                                                replies[index].content,
                                                replies[index].attachedImage
                                              ])
                                        : _forumController.deleteReply(
                                            replies[index].id!,
                                            replies[index].threadID,
                                            replies[index].attachedImage);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return {'Sửa', 'Xóa'}
                                        .map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: choice,
                                        child: Text(choice,
                                            style: TextStyle(
                                                color: AppColor.brown)),
                                      );
                                    }).toList();
                                  },
                                ),
                              )
                            : Gaps.empty,
                      ],
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ).pOnly(bottom: 6).pSymmetric(h: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: replies[index]
                          .content
                          .text
                          .size(16.0)
                          .color(AppColor.textColor)
                          .align(TextAlign.justify)
                          .make()
                          .pSymmetric(h: 8.0),
                    ),
                    replies[index].attachedImage.isNotEmpty
                        ? Image.network(
                            replies[index].attachedImage,
                            width: double.infinity,
                            height: 200,
                          ).p(8)
                        : Gaps.empty,
                    // _authController.firestoreUser.value!.uid ==
                    //         replies[index].posterID
                    //     ? Row(
                    //         children: [
                    //           BrownButton(
                    //                   label: 'Xóa',
                    //                   icon: Icons.delete,
                    //                   onPress: () {})
                    //               .pSymmetric(h: 8),
                    //           BrownButton(
                    //                   label: 'Chỉnh sửa',
                    //                   icon: Icons.edit,
                    //                   onPress: () {})
                    //               .pSymmetric(h: 8),
                    //         ],
                    //       )
                    //     : Gaps.empty,
                  ],
                ),
                separatorBuilder: (context, index) => Divider(
                  height: 12,
                  thickness: 10,
                ).pSymmetric(v: 8),
              );
            } else
              return Gaps.empty;
          });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            Gaps.vGap10,
            _buildThread(),
            _buildReplies(),
            Column(
              children: [
                Divider(
                  height: 2,
                  thickness: 2,
                ).pOnly(top: 15),
                BrownButton(
                    label: 'Trả lời',
                    icon: Icons.reply,
                    onPress: () async {
                      var userName =
                          _authController.firestoreUser.value!.userName;
                      var userID = _authController.firestoreUser.value!.uid;
                      var avatarUrl =
                          _authController.firestoreUser.value!.avatarURL!;
                      bool success = await Get.toNamed(SiteNavigation.ADDREPLY,
                          arguments: [
                            userName,
                            avatarUrl,
                            thread.title,
                            thread.id,
                            userID
                          ]);
                      if (success) {
                        _scrollController.animToBottom();
                      }
                    }).pSymmetric(v: 15),
              ],
            )
          ],
        ),
      ),
    );
  }
}
