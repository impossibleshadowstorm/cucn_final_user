import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:uicn/common/functions/class%20Functions.dart';
import 'package:uicn/services/global.dart';
import 'package:uicn/utils/constants.dart';
import 'package:get/get.dart';
import 'package:bcrypt/bcrypt.dart';

class AuthenticationController extends GetxController {
  var selectedCourse = "".obs;
  var selectedGender = "".obs;
  var enrolledYear = "".obs;
  var completionYear = "".obs;
  var loginLoading = false.obs;
  var registerLoading = false.obs;

  List<String> generateEnrolledYearsList() {
    int currentYear = DateTime.now().year;
    List<String> yearsList = [];

    for (int i = currentYear - 4; i <= currentYear; i++) {
      yearsList.add(i.toString());
    }

    return yearsList;
  }

  List<String> generateCompletionYearsList() {
    int currentYear = DateTime.now().year;
    List<String> yearsList = [];

    if (enrolledYear.value.isNotEmpty) {
      int enrolledYearInt = int.tryParse(enrolledYear.value) ?? currentYear;
      for (int i = enrolledYearInt + 1; i <= enrolledYearInt + 4; i++) {
        yearsList.add(i.toString());
      }
    }

    return yearsList;
  }

  // Function to hash the password using SHA-256
  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert the password string to bytes
    var digest = sha256.convert(bytes); // Calculate the SHA-256 hash
    return digest.toString(); // Return the hashed password as a string
  }

  // Future<String> hashPassword(String password) async {
  //   // Generate a random salt
  //   final salt = await BcryptSalt().generateAsBase64String();
  //
  //   // Hash the password using the generated salt
  //   final hashedPassword = await Bcrypt.hashPw(password, salt);
  //
  //   return hashedPassword;
  // }
  // final String hashed = BCrypt.hashpw('password', BCrypt.gensalt());

Future<int> addStudentData({
    required String uid,
    required String name,
    required String password,
    required String aboutMe,
  }) async {
    registerLoading.value = true;
    try {
      // Check if the document with the provided UID already exists
      final existingDocument = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .get();
      if (existingDocument.exists) {
        registerLoading.value = false;
        return 1;
      }

      // Hash the password using SHA-256
      final String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      // String hashedPassword = hashPassword(password);

      Map<String, dynamic> data = {
        'name': name,
        'uid': uid,
        'password': hashedPassword,
        'course': selectedCourse.value,
        'aboutMe': aboutMe.replaceAll('\n', r'\n'),
        'enrolledYear': enrolledYear.value,
        'completionYear': completionYear.value,
        'status': false
      };

      await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .set(data);
      registerLoading.value = false;
      return 2;
    } catch (e) {
      registerLoading.value = false;
      print('Error adding student data: $e');
      return 3;
    }
  }

  Future<int> login({required String uid, required String password}) async {
    loginLoading.value = true;
    try {
      final userDocument = await FirebaseFirestore.instance
          .collection('students')
          .doc(uid)
          .get();

      // If the document doesn't exist, the user is not registered
      if (!userDocument.exists) {
        loginLoading.value = false;
        return 101;
      }

      // Get the stored hashed password and salt from the document
      String storedHashedPassword = userDocument['password'];
      // Note: If you store the salt separately in Firestore, you can retrieve it here.

      Global.storageServices.setString(Constants.courseCode,
          Functions.getCodeFromCourse(userDocument['course']));
      Global.storageServices.setString(
          Constants.enrolledYear, userDocument[Constants.enrolledYear]);
      // String enteredHashedPassword = hashPassword(password);
      // String enteredHashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      // final bool checkPassword = ;

      loginLoading.value = false;
      return BCrypt.checkpw(password, storedHashedPassword) ? 1 : 102;
      // return storedHashedPassword == enteredHashedPassword ? 1 : 102;
    } catch (e) {
      loginLoading.value = false;
      print('Error logging in: $e');
      return 0;
    }
  }
}
