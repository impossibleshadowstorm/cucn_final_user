import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:uicn/controllers/unfinalized/unfinalized_main_application_controller.dart';
import 'package:uicn/utils/constants.dart';
import 'package:uicn/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

import '../../../services/global.dart';
import '../un_notification_detail_screen.dart';

class UnFinalizedProfileScreen extends StatefulWidget {
  const UnFinalizedProfileScreen({super.key});

  @override
  State<UnFinalizedProfileScreen> createState() =>
      _UnFinalizedProfileScreenState();
}

class _UnFinalizedProfileScreenState extends State<UnFinalizedProfileScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final UnFinalizedMainApplicationController
      _unFinalizedMainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: firebaseFirestore
              .collection(Constants.students)
              .doc(Global.storageServices.getString(Constants.uid))
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.w),
                          bottomRight: Radius.circular(5.w),
                        ),
                        color: Constants.primaryColor,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: AppBar().preferredSize.height,
                            right: 5.w,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Global.storageServices.removeAllData();
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: const Center(
                                  child: Icon(
                                    Icons.logout_sharp,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15.h - 60,
                            left: 50.w - 60,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/avatar.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                                color: Constants.lightGreyBorderColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 70),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                "@${snapshot.data!.data()!["name"]}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  color: Constants.lightGreyTextColor,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              child: Text(
                                snapshot.data!.data()!["name"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  color: Constants.darkBlackTextColor,
                                  fontSize: 18.5.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.w),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _unFinalizedMainApplicationController
                                      .getCourseTag(
                                          snapshot.data!.data()!["course"]),
                                  style: GoogleFonts.openSans(
                                    color: Constants.lightGreyTextColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 2.5.w),
                                Container(
                                  width: 1,
                                  height: 12.5,
                                  color: Constants.primaryColor,
                                ),
                                SizedBox(width: 2.5.w),
                                Text(
                                  // "22MCA [Null]",
                                  _unFinalizedMainApplicationController
                                      .getSessionCourseTag(
                                          snapshot.data!.data()!["course"],
                                          snapshot.data!
                                              .data()!["enrolledYear"]),
                                  style: GoogleFonts.openSans(
                                    color: Constants.lightGreyTextColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.5.w),
                            Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                snapshot.data!.data()!["aboutMe"],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: Constants.darkBlackTextColor,
                                ),
                              ),
                            ),
                            // Just to design middle color content break
                            Container(
                              height: 7.5.h,
                              decoration: BoxDecoration(
                                color: Constants.lightGreyTextColor
                                    .withOpacity(0.2),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 7.5.h,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 2.5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(5.w),
                                              bottomLeft: Radius.circular(5.w),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 2.5.h,
                                          color: Colors.transparent,
                                        ),
                                        Container(
                                          height: 2.5.h,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.w),
                                              topRight: Radius.circular(5.w),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Below Information
                            Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Information",
                                    style: GoogleFonts.openSans(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Divider(
                                    height: 2.5.h,
                                    color: Constants.darkBlackTextColor,
                                  ),
                                  informationTile(
                                    "Name",
                                    snapshot.data!.data()!["name"],
                                    Icons.book,
                                  ),
                                  SizedBox(height: 1.h),
                                  informationTile(
                                    "UID",
                                    snapshot.data!.data()!["uid"],
                                    Icons.numbers_sharp,
                                  ),
                                  SizedBox(height: 1.h),
                                  informationTile(
                                    "Course",
                                    snapshot.data!.data()!["course"],
                                    Icons.pages_outlined,
                                  ),
                                  SizedBox(height: 1.h),
                                  informationTile(
                                    "Session",
                                    "${snapshot.data!.data()!["enrolledYear"]} - ${snapshot.data!.data()!["completionYear"]}",
                                    Icons.calendar_month,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 2.5.h,
                      color: Constants.darkBlackTextColor,
                      endIndent: 5.w,
                      indent: 5.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const PdfViewerScreen(
                            url:
                                "https://firebasestorage.googleapis.com/v0/b/uicnotifier-5732d.appspot.com/o/20230817_141736.pdf?alt=media&token=608b2835-db65-44e8-b4d8-cd1f61100d5f"));
                      },
                      child: singleChips("Contact Details"),
                    ),
                    SizedBox(height: 1.5.w),
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          }),
    );
  }

  Widget singleChips(String chipText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.w),
      decoration: BoxDecoration(
        color: Constants.lightGreyBorderColor,
        borderRadius: BorderRadius.circular(1.w),
      ),
      child: Text(
        chipText,
        style: GoogleFonts.dmSans(
          color: Colors.black,
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget informationTile(String title, String data, IconData iconData) {
    return Row(
      children: [
        Row(
          children: [
            Icon(
              iconData,
              color: Constants.midGreyTextColor,
            ),
            SizedBox(width: 2.5.w),
            Text(
              title,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Constants.midGreyTextColor,
              ),
            ),
          ],
        ),
        Expanded(
          child: Text(
            data,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w400,
              fontSize: 17.sp,
              color: Constants.darkBlackTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
