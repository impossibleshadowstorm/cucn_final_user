import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uicn/services/global.dart';
import 'package:uicn/views/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/utils/constants.dart';
import '../controllers/main_application_controller.dart';
import 'dashboard/main_home_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final MainApplicationController _mainApplicationController = Get.find();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: FutureBuilder(
              future: firebaseFirestore
                  .collection(Constants.students)
                  .doc(Global.storageServices.getString(Constants.uid))
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: [
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              _mainApplicationController.xOffset.value = 0.0;
                              _mainApplicationController.yOffset.value = 0.0;
                              _mainApplicationController.isDrawerOpen.value =
                                  false;
                              _mainApplicationController.bottomNavIdx.value = 1;
                              Get.to(() => const MainHomeScreen());
                            },
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/avatar.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Constants.lightBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 2.5.w),
                                Text(
                                  snapshot.data!.data()!["name"],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Column(
                            children: [
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  _mainApplicationController.xOffset.value =
                                      0.0;
                                  _mainApplicationController.yOffset.value =
                                      0.0;
                                  _mainApplicationController
                                      .isDrawerOpen.value = false;
                                  _mainApplicationController
                                      .bottomNavIdx.value = 0;
                                  Get.to(() => const MainHomeScreen());
                                },
                                child: menuTile(
                                    Icons.notifications, "Notifications"),
                              ),
                              // SizedBox(height: 2.5.w),
                              // menuTile(Icons.info_outline, "Settings"),
                            ],
                          ),
                          SizedBox(height: 2.5.h),
                          Column(
                            children: [
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onTap: () {
                                  _mainApplicationController.xOffset.value =
                                      0.0;
                                  _mainApplicationController.yOffset.value =
                                      0.0;
                                  _mainApplicationController
                                      .isDrawerOpen.value = false;
                                  _mainApplicationController
                                      .bottomNavIdx.value = 1;
                                  Get.to(() => const MainHomeScreen());
                                },
                                child: menuTile(Icons.person, "Profile"),
                              ),
                              // SizedBox(height: 2.5.w),
                              // menuTile(Icons.info_outline, "Settings"),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              _mainApplicationController.xOffset.value = 0.0;
                              _mainApplicationController.yOffset.value = 0.0;
                              _mainApplicationController.isDrawerOpen.value =
                                  false;
                              Global.storageServices.removeAllData();
                              Get.to(() => const LoginScreen());
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.cancel,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                SizedBox(width: 2.5.w),
                                Text(
                                  'Log out',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white.withOpacity(0.5)),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Constants.primaryColor,
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget menuTile(IconData iconData, String menuName) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          color: Colors.white,
          size: 20.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          menuName.toUpperCase(),
          style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        )
      ],
    );
  }
}
