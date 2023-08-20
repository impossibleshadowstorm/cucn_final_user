import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/controllers/unfinalized/unfinalized_main_application_controller.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

class UnNotificationDetailScreen extends StatefulWidget {
  final String notificationId;

  const UnNotificationDetailScreen({
    super.key,
    required this.notificationId,
  });

  @override
  State<UnNotificationDetailScreen> createState() =>
      _UnNotificationDetailScreenState();
}

class _UnNotificationDetailScreenState
    extends State<UnNotificationDetailScreen> {
  final UnFinalizedMainApplicationController
      _unFinalizedMainApplicationController = Get.find();
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: FutureBuilder(
          future: firebaseFireStore
              .collection(Constants.notifications)
              .doc(widget.notificationId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(height: AppBar().preferredSize.height - 1.h),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    width: 100.w,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 5.h,
                            width: 5.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Constants.lightGreyBorderColor,
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_left,
                                color: Color(0xFF171B20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Details",
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
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.primaryColor,
                        ),
                        child: Text(
                          "AD",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          snapshot.data!.data()!["title"] ?? "",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         "Dr. Manisha Malhotra, AD, UIC",
                      //         textAlign: TextAlign.end,
                      //         style: GoogleFonts.openSans(
                      //           color: Constants.darkGreyTextColor,
                      //           fontSize: 16.sp,
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Obx(() {
                    return SizedBox(
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                _unFinalizedMainApplicationController
                                    .notificationDetailTabIdx.value = 0;
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      "Details",
                                      style: GoogleFonts.openSans(
                                          color: Constants.primaryColor,
                                          fontSize:
                                              _unFinalizedMainApplicationController
                                                          .notificationDetailTabIdx
                                                          .value ==
                                                      1
                                                  ? 17.sp
                                                  : 16.sp,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.25),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  _unFinalizedMainApplicationController
                                              .notificationDetailTabIdx.value ==
                                          0
                                      ? Container(
                                          height: 2,
                                          width: 35.w,
                                          color: Constants.primaryColor,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                _unFinalizedMainApplicationController
                                    .notificationDetailTabIdx.value = 1;
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Center(
                                    child: Text(
                                      "Documents",
                                      style: GoogleFonts.openSans(
                                          color: Constants.primaryColor,
                                          fontSize:
                                              _unFinalizedMainApplicationController
                                                          .notificationDetailTabIdx
                                                          .value ==
                                                      1
                                                  ? 17.sp
                                                  : 16.sp,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.25),
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  _unFinalizedMainApplicationController
                                              .notificationDetailTabIdx.value ==
                                          1
                                      ? Container(
                                          height: 2,
                                          width: 35.w,
                                          color: Constants.primaryColor,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Expanded(
                    child: Obx(() {
                      return SizedBox(
                        width: 100.w,
                        child: _unFinalizedMainApplicationController
                                    .notificationDetailTabIdx.value ==
                                0
                            ? detailsTab(snapshot.data!.data()!)
                            : documentsTab(),
                      );
                    }),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget detailsTab(var data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.5.h),
          SizedBox(
            width: 100.w,
            child: Text(
              data["message"].replaceAll(r"\n", "\n") ?? "",
              textAlign: TextAlign.justify,
              style: GoogleFonts.openSans(
                color: Colors.black54,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Divider(
            color: Constants.darkGreyTextColor,
            height: 2.h,
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              // SizedBox(width: 5.w),
              SizedBox(
                width: 30.w,
                child: Text(
                  "Valid till : ",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "25-04-2023",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 1.h),
          data["links"] != null && data["links"].length > 0
              ? Divider(
                  color: Constants.darkGreyTextColor,
                  height: 2.h,
                )
              : const SizedBox(),
          SizedBox(height: 1.h),
          data["links"] != null && data["links"].length > 0
              ? SizedBox(
                  width: 100.w,
                  child: Text(
                    "Provided Links",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                    ),
                  ),
                )
              : const SizedBox(),
          SizedBox(height: 1.h),
          // _unFinalizedMainApplicationController.links.isNotEmpty
          data["links"] != null && data["links"].length > 0
              ? SizedBox(
                  height: 55 * data["links"].length.toDouble() as double,
                  width: 100.w,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data["links"].length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              onTap: () {
                                String url =
                                    _unFinalizedMainApplicationController
                                        .validateLink(data["links"][index]);
                                _unFinalizedMainApplicationController
                                    .launchUrlInBrowser(url);
                              },
                              child: linkBoxTile(data["links"][index], index),
                            ),
                            SizedBox(height: 2.5.w),
                          ],
                        );
                      }),
                )
              : const SizedBox(),
          Divider(
            color: Constants.darkGreyTextColor,
            height: 2.h,
          ),
          SizedBox(
            width: 100.w,
            child: Text(
              "Message Posted on 25-03-2023",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 14.5.sp,
              ),
            ),
          ),
          FutureBuilder(
              future: firebaseFireStore
                  .collection(Constants.admin)
                  .doc(data["docId"])
                  .get(),
              builder: (context, snap) {
                if (snap.hasData) {
                  return SizedBox(
                    width: 100.w,
                    child: Text(
                      "Message by ${snap.data!.data()!["name"]}, ${_unFinalizedMainApplicationController.getDesignationRole(snap.data!.data()!["role"]["position"])}, UIC",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.5.sp,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              })
        ],
      ),
    );
  }

  Widget documentsTab() {
    return SingleChildScrollView(
      child: FutureBuilder(
          future: firebaseFireStore
              .collection(Constants.notifications)
              .doc(widget.notificationId)
              .get(),
          builder: (context, snapshot) {
            print(widget.notificationId);
            if (snapshot.hasData) {
              if (snapshot.data!.data()!["files"] != null && snapshot.data!.data()!["files"].length > 0) {
                double len = snapshot.data!.data()!["files"].length.toDouble();
                return Column(
                  children: [
                    SizedBox(height: 2.5.h),
                    SizedBox(
                      height: (140 * (len / 2).ceilToDouble()) + (40 * len),
                      width: 100.w,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // Number of columns
                            mainAxisSpacing: 20.0,
                            // Vertical spacing between grid items
                            crossAxisSpacing:
                                20.0, // Horizontal spacing between grid items
                          ),
                          itemCount: len.toInt(),
                          itemBuilder: (context, index) {
                            return fileTile(
                                snapshot.data!.data()!["files"][index], index);
                          }),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text(
                    "No Any Document is attached",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          }),
    );
  }

  Widget fileTile(var fileType, int index) {
    return Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.5.w),
        border: Border.all(color: Constants.lightGreyTextColor),
      ),
      child: fileType.toString().contains('.pdf')
          ? InkWell(
              onTap: () {
                Get.to(() => PdfViewerScreen(url: fileType.toString()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "PDF",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : fileType.toString().contains('.jpg') ||
                  fileType.toString().contains('.png') ||
                  fileType.toString().contains('.jpeg')
              ? FullScreenWidget(
                disposeLevel: DisposeLevel.High,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: NetworkImage(fileType),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              )
              : const SizedBox(),
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

  Widget linkBoxTile(String link, int index) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Constants.lightGreyBorderColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.insert_link_sharp,
              color: Constants.primaryColor,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            "Link - ${index + 1}",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String url;

  const PdfViewerScreen({super.key, required this.url});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFDocument? document;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePdf();
  }

  void initializePdf() async {
    document = await PDFDocument.fromURL(widget.url);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(
              document: document!,
            )
          : Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            ),
    );
  }
}
