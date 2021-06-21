import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floradb/common_widget/forum/thread_tile.dart';
import 'package:floradb/common_widget/text_with_border.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/gen/assets.gen.dart';
import 'package:floradb/model/forum/thread.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/site_navigation.dart';
import 'package:floradb/ui/home/home_drawer.dart';
import 'package:floradb/common_widget/header.dart';
import 'package:floradb/res/gaps.dart';
import 'package:floradb/common_widget/plant/plant_categories_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  ForumController _forumController = Get.find();

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
        title: 'myPlant'.text.semiBold.color(AppColor.green).make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gaps.vGap8,
            GestureDetector(
              onTap: () => Get.toNamed(SiteNavigation.MYPLANT),
              child: Card(
                color: Colors.green[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextWithBorder(
                      text: 'Cây cảnh\ncủa bạn',
                      size: 35,
                      borderColor: Colors.black,
                      fillColor: Colors.white,
                      strokeWidth: 4,
                    ).pOnly(left: 10),
                    Assets.images.myplant.image(width: 120, height: 120).p(10),
                  ],
                ),
              ).pSymmetric(h: 4),
            ),
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: Header('Danh mục cây cảnh', haveSeemore: false),
            ),
            PlantCategoryGrid(haveSeeMore: true),
            Gaps.vGap8,
            Align(
              alignment: Alignment.centerLeft,
              child: Header('Chủ đề thảo luận mới', haveSeemore: false),
            ),
            StreamBuilder(
                stream: _forumController.streamNewestThreads(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Gaps.empty;
                  } else {
                    List<ForumThread> threads = snapshot.data!.docs
                        .map((thread) => ForumThread.fromQuerySnapshot(thread))
                        .toList();
                    var threadTiles = threads
                        .map((ForumThread e) => ThreadTile.buildInstance(e))
                        .toList();
                    return ListView.separated(
                      itemCount: threadTiles.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => threadTiles[index],
                      separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                      ).pSymmetric(h: 16),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
