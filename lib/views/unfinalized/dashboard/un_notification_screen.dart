import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/common/functions/class%20Functions.dart';
import 'package:uicn/controllers/unfinalized/unfinalized_main_application_controller.dart';
import 'package:uicn/utils/constants.dart';
import 'package:uicn/views/unfinalized/un_notification_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnFinalizedNotificationScreen extends StatefulWidget {
  const UnFinalizedNotificationScreen({super.key});

  @override
  State<UnFinalizedNotificationScreen> createState() =>
      _UnFinalizedNotificationScreenState();
}

class _UnFinalizedNotificationScreenState
    extends State<UnFinalizedNotificationScreen> {
  final UnFinalizedMainApplicationController
      _unFinalizedMainApplicationController = Get.find();
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<String> getDataFromAdminCollection(String docId) async {
    final UnFinalizedMainApplicationController
        _unFinalizedMainApplicationController = Get.find();
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(Constants.admin)
          .doc(docId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        print('Data from admin collection: $data');
        return data['name'] ?? '';
      } else {
        print('Document does not exist');
        return "";
      }
    } catch (e) {
      print('Error getting document: $e');
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: AppBar().preferredSize.height - 1.h),
            SizedBox(
              height: AppBar().preferredSize.height,
              width: 100.w,
              child: Row(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     Get.back();
                  //   },
                  //   child: Container(
                  //     height: 5.h,
                  //     width: 5.h,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.white,
                  //       border: Border.all(
                  //         color: Constants.lightGreyBorderColor,
                  //         width: 1,
                  //       ),
                  //     ),
                  //     child: const Center(
                  //       child: Icon(
                  //         AntDesign.arrowleft,
                  //         color: Color(0xFF171B20),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Notifications",
                        style: GoogleFonts.poppins(
                          color: Constants.primaryColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Expanded(
              child: FutureBuilder(
                  future: firebaseFireStore
                      .collection(Constants.notifications)
                      .orderBy('timestamp', descending: true)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                notificationTile(
                                    snapshot.data!.docs[index].data(), snapshot.data!.docs[index].id),
                                SizedBox(height: 2.5.w),
                              ],
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ),
                    );
                  }),
            ),
            Divider(
              height: 1.h,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  Widget notificationTile(var data, String id) {
    return Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: Constants.lightGreyBorderColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(1.5.w),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => UnNotificationDetailScreen(
                      notificationId: id,
                    ));
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.5.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.primaryColor,
                        ),
                        child: Text(
                          "AD",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(width: 2.5.w),
                      Expanded(
                        child: Text(
                          data["title"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    width: 100.w,
                    child: Text(
                      data["message"].replaceAll(r"\n", "\n") ?? "",
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Constants.darkGreyTextColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FutureBuilder(
                          future: firebaseFireStore
                              .collection(Constants.admin)
                              .doc(data["docId"])
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "- ${snapshot.data!.data()!["name"]}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 4.h,
              color: Constants.darkGreyTextColor,
            ),
            SizedBox(
              width: 100.w,
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      singleChips(data["creationDate"] ?? ""),
                      Container(
                        height: 10,
                        width: 3.5.w,
                        color: Constants.lightGreyBorderColor,
                      ),
                      singleChips(data["validityDate"] ?? ""),
                      SizedBox(width: 2.5.w),
                      singleChips(data["creationTime"] ?? ""),
                      SizedBox(width: 2.5.w),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
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
}
