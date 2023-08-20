import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../views/finalized/dashboard/main/dashboard/dashboard_screen.dart';
import '../views/finalized/dashboard/main/notification/notification_screen.dart';
import '../views/finalized/dashboard/main/profile/profile_screen.dart';


class MainApplicationController extends GetxController {
  var authIdx = 0.obs;
  var finalizedBottomNavIdx = 0.obs;
  var loginShow = true.obs;
  var signupShow = true.obs;
  var confmSignupShow = true.obs;

  // Dashboard
  List<Widget> finalizedBottomNavScreens = [
    const DashboardScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
}
