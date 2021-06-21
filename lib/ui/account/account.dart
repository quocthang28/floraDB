import 'package:floradb/common_widget/text_with_border.dart';
import 'package:floradb/common_widget/user_avatar.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/controller/qa_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/gen/assets.gen.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/res/gaps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<Account> {
  final AuthController _authController = Get.find();
  final ForumController _forumController = Get.find();
  final QAController _qaController = Get.find();
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var user = _authController.firestoreUser.value!;
    String level = _authController.isAd.value ? 'Admin' : 'Thành viên';
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColor.green),
        title: 'Tài khoản'.text.semiBold.color(AppColor.green).make(),
        actions: [
          IconButton(
            onPressed: () => _authController.signOut(),
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(w: 100.0, h: 100.0, r: 30.0)
                  .pOnly(top: 8, left: 8, right: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  user.userName.text.size(20).make(),
                  'Cấp độ: $level'.text.make(),
                  Row(
                    children: [
                      'Ngày gia nhập: '.text.make(),
                      DateFormat('d/M/y').format(now).text.make(),
                    ],
                  ),
                ],
              ).expand(),
            ],
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
//todo: list thread, question started by user

class DrawerAction extends StatelessWidget {
  DrawerAction({required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Icon(icon, color: AppColor.brown),
      title: title.text.size(18.0).color(AppColor.brown).make(),
    );
  }
}
