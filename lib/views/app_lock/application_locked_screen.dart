import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uicn/common/custom_toasts.dart';
import 'package:uicn/common/widgets/common_button.dart';

class ApplicationLockedScreen extends StatefulWidget {
  const ApplicationLockedScreen({super.key});

  @override
  State<ApplicationLockedScreen> createState() =>
      _ApplicationLockedScreenState();
}

class _ApplicationLockedScreenState extends State<ApplicationLockedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Your Application is Locked!",
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                CustomToasts.errorToast(context, "Please Update your application or wait for next Update..!");
              },
              child: CommonButton.primaryFilledButton(
                  null, null, "Update Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
