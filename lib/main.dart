import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:uicn/firebase_options.dart';
import 'package:uicn/services/global.dart';
// import 'home.dart';
import 'package:uicn/controllers/main_animation_controller.dart';
import 'package:uicn/controllers/main_application_controller.dart';
import 'package:uicn/controllers/unfinalized/unfinalized_main_application_controller.dart';
import 'package:uicn/utils/responsive.dart';
import 'package:uicn/views/common/error_screen.dart';
import 'package:uicn/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'controllers/authentication_controller/authentication_controller.dart';


Future<void> main() async {
  await Global.init();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MainAnimationController mainAnimationController =
  Get.put(MainAnimationController());
  MainApplicationController mainApplicationController =
  Get.put(MainApplicationController());
  AuthenticationController authenticationController =
  Get.put(AuthenticationController());
  UnFinalizedMainApplicationController unFinalizedMainApplicationController =
  Get.put(UnFinalizedMainApplicationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, type) {
      return GetMaterialApp(
        title: 'UIC Notifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          // useMaterial3: true,
        ),
        home: ResponsiveWidget.isSmallScreen(context)
            ? const SplashScreen()
            : const ErrorScreen(
          errorText: "Please Open in Android or Ios Device",
        ),
      );
    });
  }
}