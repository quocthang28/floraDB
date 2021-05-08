import 'package:firebase_core/firebase_core.dart';
import 'package:floradb/controller/auth_controller.dart';
import 'package:floradb/controller/plant_category_controller.dart';
import 'package:floradb/controller/user_controller.dart';
import 'package:floradb/service/database_service.dart';
import 'package:floradb/site_navigation.dart';
import 'package:floradb/ui/home.dart';
import 'package:floradb/ui/login.dart';
import 'package:floradb/ui/plant_category_detail.dart';
import 'package:floradb/ui/sign_up.dart';
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
        primaryColor: Colors.lightGreen.shade100,
        accentColor: Colors.lightGreen.shade100,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionColor: Colors.green[200],
          selectionHandleColor: Colors.green,
        ),
        fontFamily: GoogleFonts.sourceSansPro().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController());
        Get.lazyPut<DatabaseService>(() => DatabaseService(), fenix: true);
        Get.lazyPut<UserController>(() => UserController(), fenix: true);
        Get.lazyPut<PlantCategoryController>(() => PlantCategoryController(),
            fenix: true);
      }),
      initialRoute: SiteNavigation.SPLASH,
      getPages: [
        GetPage(name: SiteNavigation.SPLASH, page: () => SplashScreen()),
        GetPage(name: SiteNavigation.LOGIN, page: () => LoginScreen()),
        GetPage(name: SiteNavigation.SIGNUP, page: () => SignUpScreen()),
        GetPage(name: SiteNavigation.HOME, page: () => HomeScreen()),
        GetPage(
            name: SiteNavigation.PLANTCATEGORYDETAIL,
            page: () => PlantCategoryDetail()),
      ],
    );
  }
}
