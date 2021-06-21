import 'package:firebase_core/firebase_core.dart';
import 'package:floradb/controller/app_controller.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/forum_controller.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:floradb/controller/plant_controller.dart';
import 'package:floradb/controller/qa_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/res/app_color.dart';
import 'package:floradb/service/database_service.dart';
import 'package:floradb/site_navigation.dart';
import 'package:floradb/ui/forum/add_reply.dart';
import 'package:floradb/ui/forum/add_thread.dart';
import 'package:floradb/ui/forum/all_threads.dart';
import 'package:floradb/ui/forum/edit_reply.dart';
import 'package:floradb/ui/forum/edit_thread.dart';
import 'package:floradb/ui/forum/thread_detail.dart';
import 'package:floradb/ui/main_screen.dart';
import 'package:floradb/ui/my_plant/my_plant.dart';
import 'package:floradb/ui/plant/plant_detail.dart';
import 'package:floradb/ui/plant_category/all_plant_categories.dart';
import 'package:floradb/ui/home/home.dart';
import 'package:floradb/ui/auth/login.dart';
import 'package:floradb/ui/plant_category/plant_category_detail.dart';
import 'package:floradb/ui/auth/sign_up.dart';
import 'package:floradb/ui/qanda/add_question.dart';
import 'package:floradb/ui/qanda/question_detail.dart';
import 'package:floradb/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'floraDB',
      theme: ThemeData(
        primaryColor: AppColor.green,
        accentColor: AppColor.green,
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.lightGreen,
          selectionColor: Colors.lightGreen,
          selectionHandleColor: Colors.lightGreen,
        ),
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController(), permanent: true);
        Get.put<AppController>(AppController(), permanent: true);
        Get.lazyPut<DatabaseService>(() => DatabaseService(), fenix: true);
        Get.lazyPut<UserController>(() => UserController(), fenix: true);
        Get.lazyPut<PlantCategoryController>(() => PlantCategoryController(),
            fenix: true);
        Get.lazyPut<PlantController>(() => PlantController(), fenix: true);
        Get.lazyPut<ForumController>(() => ForumController(), fenix: true);
        Get.lazyPut<QAController>(() => QAController(), fenix: true);
      }),
      initialRoute: SiteNavigation.SPLASH,
      getPages: [
        GetPage(name: SiteNavigation.SPLASH, page: () => SplashScreen()),
        GetPage(name: SiteNavigation.MAIN, page: () => MainScreen()),
        GetPage(name: SiteNavigation.LOGIN, page: () => LoginScreen()),
        GetPage(name: SiteNavigation.SIGNUP, page: () => SignUpScreen()),
        GetPage(name: SiteNavigation.HOME, page: () => HomeScreen()),
        GetPage(
            name: SiteNavigation.ALLCATEGORIES, page: () => AllCategories()),
        GetPage(
            name: SiteNavigation.PLANTCATEGORYDETAIL,
            page: () => PlantCategoryDetail()),
        GetPage(name: SiteNavigation.PLANTDETAIL, page: () => PlantDetail()),
        GetPage(name: SiteNavigation.ALLTHREADS, page: () => AllThreads()),
        GetPage(name: SiteNavigation.THREADDETAIL, page: () => ThreadDetail()),
        GetPage(name: SiteNavigation.ADDREPLY, page: () => AddReply()),
        GetPage(name: SiteNavigation.ADDTHREAD, page: () => AddThread()),
        GetPage(name: SiteNavigation.EDITREPLY, page: () => EditReply()),
        GetPage(name: SiteNavigation.EDITTHREAD, page: () => EditThread()),
        GetPage(name: SiteNavigation.ADDQUESTION, page: () => AddQuestion()),
        GetPage(
            name: SiteNavigation.QUESTIONDETAIL, page: () => QuestionDetail()),
        GetPage(name: SiteNavigation.MYPLANT, page: () => MyPlant()),
      ],
    );
  }
}
