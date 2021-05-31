import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AppTab { HOME, FORUM, QA, ACCOUNT }

class AppController extends GetxController {
  GlobalKey keyMenuHome = GlobalKey();
  GlobalKey keyMenuForum = GlobalKey();
  GlobalKey keyMenuQA = GlobalKey();
  GlobalKey keyMenuAccount = GlobalKey();

  final mainTabStream = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  void goToTab(AppTab tab) {
    switch (tab) {
      case AppTab.HOME:
        mainTabStream.value = 0;
        break;
      case AppTab.FORUM:
        mainTabStream.value = 1;
        break;
      case AppTab.QA:
        mainTabStream.value = 2;
        break;
      case AppTab.ACCOUNT:
        mainTabStream.value = 3;
        break;
    }
  }
}

final appState = Get.put(AppController());
