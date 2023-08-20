import 'package:uicn/controllers/main_application_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import 'login_panel.dart';

class LoginScreen extends StatefulWidget {
  final bool back;
  const LoginScreen({super.key, this.back = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: SlidingUpPanel(
          controller: panelController,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.5.w),
            topRight: Radius.circular(7.5.w),
          ),
          minHeight: 70.h,
          maxHeight: 70.h,
          // parallaxEnabled: true,
          // parallaxOffset: 0.4,
          body: Container(
            // height: 50.h,
            width: 100.w,
            padding: EdgeInsets.all(2.h),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppBar().preferredSize.height),
                widget.back ? Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ) : const SizedBox(),
                SizedBox(height: 2.h),
                Text(
                  "Go ahead and set\nyour account",
                  style: TextStyle(
                    fontSize: 23.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Sign in up to enjoy the best experience",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          panelBuilder: () => LoginPanel(
            panelController: panelController,
          ),
        ),
      ),
    );
  }
}
