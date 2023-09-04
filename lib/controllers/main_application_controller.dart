import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../views/dashboard/notifications/notification_screen.dart';
import '../views/dashboard/profile/profile_screen.dart';


class MainApplicationController extends GetxController {
  var authIdx = 0.obs;
  var bottomNavIdx = 0.obs;
  var loginShow = true.obs;
  var signupShow = true.obs;
  var confirmSignupShow = true.obs;

  // Drawer
  var xOffset = 0.0.obs;
  var yOffset = 0.0.obs;

  var isDrawerOpen = false.obs;

  // Dashboard
  List<Widget> bottomNavScreens = [
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  List<GButton> bottomNavIconsList = [
    const GButton(
      icon: Icons.notifications,
      text: "Notifications",
    ),
    const GButton(
      icon: Icons.person,
      text: "Profile",
    ),
  ];


  var notificationDetailTabIdx = 0.obs;
  List<String> chipsData = ["24-03-2023", "25-03-2023", "23:30"];

  String validateLink(String link) {
    if (link.startsWith('http://www.') || link.startsWith('https://www.')) {
      return link;
    } else if (link.startsWith('www.')) {
      return 'https://$link';
    } else {
      return 'https://$link'; // Invalid link
    }
  }

  String getDesignationRole(String role) {
    String data;
    role == "Additional Director"
        ? data = "AD"
        : role == "Head Of Department"
        ? data = "HOD"
        : data = "Coordinator";

    return data;
  }

  launchUrlInBrowser(String url) {
    launchUrl(Uri.parse(url));
  }

  String getCourseTag(String course) {
    var s = course.split(" ")[0];

    return s;
  }

  String getSessionCourseTag(String course, String year) {
    String lastTwoCharacters = year.substring(year.length - 2);
    var s = "$lastTwoCharacters${course.split(" ")[0]}";

    return s;
  }
}
