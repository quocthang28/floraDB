import 'package:floradb/common_widget/custom_bottom_appbar.dart';
import 'package:floradb/controller/app_controller.dart';
import 'package:floradb/controller/refresh_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/ui/account/account.dart';
import 'package:floradb/ui/forum/forum_home.dart';
import 'package:floradb/ui/qanda/qanda.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home/home.dart';

class TabData {
  CustomBottomAppBarItem tabButton;
  Widget tabBody;

  TabData(this.tabBody, this.tabButton);
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final AppController _appController = Get.find();
  final _pageController = PageController();
  int _currentIndex = 0;
  List<TabData> _tabList = [];

  void _initTabList() {
    TabData homeTab = TabData(
        HomeScreen(),
        CustomBottomAppBarItem(
          key: appState.keyMenuHome,
          icon: Icons.home_outlined,
          title: 'Trang chủ',
        ));

    TabData forumTab = TabData(
        ForumHome(),
        CustomBottomAppBarItem(
          key: appState.keyMenuForum,
          icon: Icons.forum_outlined,
          title: 'Diễn đàn',
        ));

    TabData qaTab = TabData(
        QandA(),
        CustomBottomAppBarItem(
          key: appState.keyMenuQA,
          //todo: add q and a icon
          icon: Icons.question_answer,
          title: 'Hỏi đáp',
        ));

    TabData accountTab = TabData(
        Account(),
        CustomBottomAppBarItem(
          key: appState.keyMenuAccount,
          icon: Icons.account_circle_outlined,
          title: 'Tài khoản',
        ));

    _tabList = [homeTab, forumTab, qaTab, accountTab];
  }

  void _onTap(int? index) {
    _pageController.jumpToPage(index ?? 0);
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _listenToTabChange() {
    _appController.mainTabStream.stream.listen((index) {
      _onTap(index);
    });
  }

  @override
  void initState() {
    _initTabList();
    _listenToTabChange();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: refreshController.refreshStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _tabList.map((e) => e.tabBody).toList(),
              physics: NeverScrollableScrollPhysics(), // No sliding
            ),
            bottomNavigationBar: CustomBottomAppBar(
              color: Colors.grey,
              currentIndex: _currentIndex,
              selectedColor: AppColor.brown,
              onTabSelected: _onTap,
              items: _tabList.map((e) => e.tabButton).toList(),
            ),
          );
        });
  }
}
