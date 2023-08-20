import 'package:uicn/views/unfinalized/dashboard/un_notification_screen.dart';
import 'package:uicn/views/unfinalized/dashboard/un_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class UnFinalizedMainApplicationController extends GetxController {
  var bottomPageIdx = 0.obs;
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

  List<Widget> bottomNavPages = [
    const UnFinalizedNotificationScreen(),
    const UnFinalizedProfileScreen(),
  ];

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
