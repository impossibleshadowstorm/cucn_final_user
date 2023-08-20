import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/services/global.dart';
import 'package:uicn/utils/constants.dart';

class Functions {
  static String getCodeFromCourse(String courseString) {
    int hyphenIndex = courseString.indexOf('-');
    if (hyphenIndex != -1 && hyphenIndex + 1 < courseString.length) {
      return courseString.substring(hyphenIndex + 1).trim();
    }
    return '';
  }

  // Check if sectioning is finalized
  static Future<dynamic> checkForFinalization() async {
    final String? enrolledYear = Global.storageServices.getString(Constants.enrolledYear);
    final String? courseCode = Global.storageServices.getString(Constants.courseCode)?.toLowerCase();
    try {
      final finalizationData = await FirebaseFirestore.instance
          .collection(Constants.externalData)
          .doc(Constants.finalization)
          .get();



      return finalizationData[enrolledYear!][courseCode];
    } catch (e) {
      print('Error logging in: $e');
      return 0;
    }
  }

  static Future<String> getFacultyName(String eid, String courseCode) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var userList = await firebaseFirestore.collection(Constants.admin).get();
    print(userList);

    return "";
  }
}
