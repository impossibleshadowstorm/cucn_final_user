import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../utils/constants.dart';

class CommonButton {
  static Widget primaryFilledButton(
      double? height, double? width, String buttonText) {
    return Container(
      height: height ?? 5.5.h,
      width: width ?? 100.w,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget primaryFilledProgressButton(
      double? height, double? width) {
    return Container(
      height: height ?? 6.h,
      width: width ?? 100.w,
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white)
      ),
    );
  }
}
