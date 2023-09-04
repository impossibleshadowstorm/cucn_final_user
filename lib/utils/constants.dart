import 'dart:ui';

class Constants {
  //----------------------------------------------------------------
  // Color Constants
  //----------------------------------------------------------------
  // static Color primaryColor = const Color(0xff6F947D);
  static Color primaryColor = const Color(0xff111B31);
  static Color primaryDarkBlueColor = const Color(0xff111B31);
  static Color lightGreyBorderColor = const Color(0xffEEF0F2);
  static Color darkGreyTextColor = const Color(0xffB4B5C3);
  static Color midGreyTextColor = const Color(0xffB4B5C3);
  static Color lightGreyTextColor = const Color(0xFF707E94);
  static Color darkBlackTextColor = const Color(0xFF060606);
  static Color lightBackgroundColor = const Color(0xFFF9F9F9);

  //----------------------------------------------------------------
  // Lists Constants
  //----------------------------------------------------------------
  static List<String> courseList = [
    "BCA [General] - BC201",
    "BCA [AR/VR] - BC204",
    "BCA [UI/UX] - BC205",
    "BSC [CS] - BC206",
    "MCA [General] - MC305",
    "MCA [AI/ML] - MC306",
    "MCA [CC] - MC307",
  ];

  static List<String> genderList = ["Male", "Female", "Other"];

  //----------------------------------------------------------------
  // Notifications Key Constants
  //----------------------------------------------------------------
  static const String everyone = "ALL";
  static const String allUG = "ALL-UG";
  static const String allPG = "ALL-PG";
  static const String mcaGeneral = "MCA";
  static const String mcaCloud = "MCC";
  static const String mcaAI = "MCI";
  static const String bcaGeneral = "BCA";
  static const String bcaAR = "BCV";
  static const String bcaUI = "BCU";
  static const String bsc = "BSC";

  // ----------------------------------------------------------------
  // Preferences Key Constants
  //----------------------------------------------------------------
  static const String uid = "uid";
  static const String courseCode = "course_code";
  static const String finalized = "finalized";
  static const String enrolledYear = "enrolledYear";

  //----------------------------------------------------------------
  // Collection Names Constants
  //----------------------------------------------------------------
  static const String admin = "admin";
  static const String students = "students";
  static const String notifications = "notifications";
  static const String externalData = "external_data";

  //----------------------------------------------------------------
  // Document Names Constants
  //----------------------------------------------------------------
  static const String finalization = "finalization";
}
