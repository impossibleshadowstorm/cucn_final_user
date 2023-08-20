import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/common/functions/class%20Functions.dart';
import 'package:uicn/services/global.dart';
import 'package:uicn/utils/constants.dart';
import 'package:uicn/views/app_lock/lock_animation_screen.dart';
import 'package:uicn/views/auth/login_screen.dart';
import 'package:uicn/views/common/error_screen.dart';
import 'package:uicn/views/finalized/dashboard/main/main_home_screen.dart';
import 'package:uicn/views/unfinalized/dashboard/un_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController controller;
  late GravitySimulation simulation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simulation = GravitySimulation(
      100.0, // acceleration
      0.0, // starting point
      50.h - 70, // end point
      1500.0, // starting velocity
    );
    controller = AnimationController(
        vsync: this,
        upperBound: 50.h - 70,
        duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    controller.animateWith(simulation);


    // Global.storageServices.removeAllData();
    checkForScreens();
    // () async {
    // }();
  }

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  checkForScreens() {
    // print(Global.storageServices.getString(Constants.uid));
    if (Global.storageServices.getString(Constants.uid) != null &&
        Global.storageServices.getString(Constants.courseCode) != null) {
      if (Global.storageServices.getBool(Constants.finalized)) {
        Timer(
          const Duration(seconds: 3),
          () => Get.offAll(
            () => const MainHomeScreen(),
            transition: Transition.leftToRight,
            curve: Curves.easeInOutQuad,
          ),
        );
      } else {
        Functions.checkForFinalization().then((value) async {
          if (value == true) {
            await _fireStore
                .collection(Constants.students)
                .doc(Global.storageServices.getString(Constants.uid))
                .get()
                .then((value) {
              if (value.data()!["status"]) {
                Global.storageServices.setBool(Constants.finalized, true);
                Timer(
                  const Duration(seconds: 3),
                  () => Get.offAll(
                    () => const MainHomeScreen(),
                    transition: Transition.leftToRight,
                    curve: Curves.easeInOutQuad,
                  ),
                );
              } else {
                Timer(
                  const Duration(seconds: 3),
                  () => Get.offAll(
                    () => const LockAnimationScreen(),
                    transition: Transition.leftToRight,
                    curve: Curves.easeInOutQuad,
                  ),
                );
              }
            }).catchError((e) {
              print(e.toString());
            });
            // Global.storageServices.setBool(Constants.finalized, true);
            // Timer(
            //   const Duration(seconds: 3),
            //   () => Get.offAll(
            //     () => const MainHomeScreen(),
            //     transition: Transition.leftToRight,
            //     curve: Curves.easeInOutQuad,
            //   ),
            // );
          } else if (value == false) {
            Timer(
              const Duration(seconds: 3),
              () => Get.offAll(
                () => const UnFinalizedMainHomeScreen(),
                transition: Transition.leftToRight,
                curve: Curves.easeInOutQuad,
              ),
            );
          } else {
            Timer(
              const Duration(seconds: 3),
              () => Get.offAll(
                () => const ErrorScreen(
                    errorText: "Unable to fetch your batch details..!!"),
                transition: Transition.leftToRight,
                curve: Curves.easeInOutQuad,
              ),
            );
          }
        });
      }
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Get.offAll(
          () => const LoginScreen(),
          transition: Transition.leftToRight,
          curve: Curves.easeInOutQuad,
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: Column(
                children: [
                  Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff111B31),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(35.w),
                        bottomLeft: Radius.circular(35.w),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                          "UIC Notifier",
                          style: GoogleFonts.timmana(
                            color: const Color(0xff111B31),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              // top: 50.h - 70,
              top: controller.value,
              left: 50.w - 70,
              child: InkWell(
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/images/no_bg_logo.png")),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(
                          0.0,
                          0.0,
                        ),
                        blurRadius: 6.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
