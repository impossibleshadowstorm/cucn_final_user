import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uicn/common/custom_toasts.dart';
import 'package:uicn/common/functions/class%20Functions.dart';
import 'package:uicn/controllers/authentication_controller/authentication_controller.dart';
import 'package:uicn/services/global.dart';
import 'package:uicn/views/app_lock/application_locked_screen.dart';
import 'package:uicn/views/common/error_screen.dart';
import 'package:uicn/views/finalized/dashboard/main/main_home_screen.dart';
import 'package:uicn/views/unfinalized/dashboard/un_main_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import '../../common/widgets/common_button_progress_indicator.dart';
import '../../common/form_validation/form_validation.dart';
import '../../common/widgets/common_button.dart';
import '../../common/widgets/common_input_field.dart';
import '../../common/widgets/custom_dropdown.dart';
import '../../controllers/main_application_controller.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

import 'final_registration/final_registration_form_screen.dart';

class LoginPanel extends StatefulWidget {
  final PanelController panelController;

  const LoginPanel({Key? key, required this.panelController}) : super(key: key);

  @override
  State<LoginPanel> createState() => _LoginPanelState();
}

class _LoginPanelState extends State<LoginPanel> {
  final MainApplicationController _mainApplicationController = Get.find();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  TextEditingController loginUID = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpUID = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpConfirmPassword = TextEditingController();
  TextEditingController signUpAboutMe = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.w),
      margin: EdgeInsets.symmetric(vertical: 7.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(7.5.w), topRight: Radius.circular(7.5.w)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
            height: 60,
            width: 100.w,
            decoration: BoxDecoration(
              color: const Color(0xffEEF0F2),
              borderRadius: BorderRadius.circular(50.sp),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                tabBox(0, "Login", true),
                SizedBox(width: 2.5.w),
                tabBox(1, "Register", false),
              ],
            ),
          ),
          SizedBox(height: 3.5.h),
          Obx(
            () => _mainApplicationController.authIdx.value == 0
                ? loginTab()
                : registerTab(),
          )
        ],
      ),
    );
  }

  Widget tabBox(int index, String tabName, bool active) {
    return Expanded(
      child: InkWell(
        onTap: () {
          _mainApplicationController.authIdx.value = index;
        },
        child: Obx(() {
          return Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: _mainApplicationController.authIdx.value == index
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                tabName,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget loginTab() {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return Form(
      key: _formKey,
      child: Obx(() {
        return Column(
          children: [
            CommonInputField.textInputField(
              loginUID,
              "UID",
              FormValidation.emptyValidatorFunction,
              Icons.numbers_sharp,
            ),
            SizedBox(height: 2.5.h),
            CommonInputField.passwordInputField(
              loginPassword,
              "Password",
              FormValidation.emptyValidatorFunction,
              "login",
            ),
            SizedBox(height: 2.h),
            SizedBox(
              height: 5.h,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(),
                  // Text(
                  //   "Forgot password ?",
                  //   style: TextStyle(color: Constants.primaryColor),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            _authenticationController.loginLoading.value
                ? CommonButton.primaryFilledProgressButton(null, null)
                : InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _authenticationController
                            .login(
                          uid: loginUID.text.toUpperCase(),
                          password: loginPassword.text,
                        )
                            .then((value) {
                          if (value == 101) {
                            CustomToasts.errorToast(context,
                                "User Doesn't Exists. Please register Yourself.");
                          } else if (value == 1) {
                            CustomToasts.successToast(
                                context, "Login Successful..!");
                            Global.storageServices
                                .setString(Constants.uid, loginUID.text.toUpperCase());
                            Functions.checkForFinalization().then((value) async {
                              if (value == true) {
                                await _firestore.collection(Constants.students).doc(Global.storageServices.getString(Constants.uid)).get().then((value) {
                                  if (value.data()!["status"]){
                                    Global.storageServices
                                        .setBool(Constants.finalized, true);
                                    Get.offAll(() => const MainHomeScreen());
                                  }
                                  else{
                                    Get.offAll(() => const ApplicationLockedScreen());
                                  }
                                }).catchError((e){
                                  print(e.toString());
                                });
                              } else if (value == false) {
                                Get.offAll(
                                    () => const UnFinalizedMainHomeScreen());
                              } else {
                                Global.storageServices
                                    .removeData(Constants.courseCode);
                                CustomToasts.errorToast(context,
                                    "Unable to get your batch details. Try again later.");
                              }
                            });
                          } else if (value == 102) {
                            CustomToasts.errorToast(
                                context, "Incorrect Password or Username");
                          } else {
                            CustomToasts.errorToast(context,
                                "Error Signing Up! Please Try again Later..!!");
                          }
                        });
                      }
                    },
                    child:
                        CommonButton.primaryFilledButton(null, null, "Login"),
                  ),
            SizedBox(height: 5.h),
          ],
        );
      }),
    );
  }

  Widget registerTab() {
    return Form(
      key: _formKey,
      child: Obx(() {
        return Column(
          children: [
            CommonInputField.textInputField(
              signUpName,
              "Name",
              FormValidation.emptyValidatorFunction,
              Icons.person_2_outlined,
            ),
            SizedBox(height: 2.5.h),
            CommonInputField.textInputField(
              signUpUID,
              "UID",
              FormValidation.uidValidatorFunction,
              Icons.numbers_sharp,
            ),
            SizedBox(height: 2.5.h),
            CommonInputField.passwordInputField(
              signUpPassword,
              "Password",
              FormValidation.passwordValidatorFunction,
              "signup",
            ),
            SizedBox(height: 2.5.h),
            CommonInputField.passwordInputField(
              signUpConfirmPassword,
              "Confirm Password",
              FormValidation.passwordValidatorFunction,
              "signup Confirm"
            ),
            SizedBox(height: 2.5.h),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.5.w),
              decoration: BoxDecoration(
                border: Border.all(color: Constants.lightGreyBorderColor),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.my_library_books_outlined,
                    color: Constants.primaryColor,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Obx(() {
                      return CustomDropdown(
                        items: Constants.courseList,
                        hintText: "Course",
                        selectedValue: _authenticationController
                                .selectedCourse.value.isEmpty
                            ? null
                            : _authenticationController.selectedCourse.value,
                        onChanged: (newValue) {
                          _authenticationController.selectedCourse.value =
                              newValue;
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.5.h),
            Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.5.w),
              decoration: BoxDecoration(
                border: Border.all(color: Constants.lightGreyBorderColor),
                borderRadius: BorderRadius.circular(1.w),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Constants.primaryColor,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Obx(() {
                      return CustomDropdown(
                        items: Constants.genderList,
                        hintText: "Gender",
                        selectedValue: _authenticationController
                            .selectedGender.value.isEmpty
                            ? null
                            : _authenticationController.selectedGender.value,
                        onChanged: (newValue) {
                          _authenticationController.selectedGender.value =
                              newValue;
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.5.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enrolled Year",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.5.w),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Constants.lightGreyBorderColor),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Constants.primaryColor,
                              size: 17.sp,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Obx(() {
                                return CustomDropdown(
                                  items: _authenticationController
                                      .generateEnrolledYearsList(),
                                  hintText: "Enrolled",
                                  selectedValue: _authenticationController
                                          .enrolledYear.value.isEmpty
                                      ? null
                                      : _authenticationController
                                          .enrolledYear.value,
                                  onChanged: (newValue) {
                                    _authenticationController
                                        .enrolledYear.value = newValue;
                                    _authenticationController
                                        .completionYear.value = "";
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Completion Year",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 1.w),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.5.w),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Constants.lightGreyBorderColor),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Constants.primaryColor,
                              size: 17.sp,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Obx(() {
                                return CustomDropdown(
                                  items: _authenticationController
                                      .generateCompletionYearsList(),
                                  hintText: "Completion",
                                  selectedValue: _authenticationController
                                          .completionYear.value.isEmpty
                                      ? null
                                      : _authenticationController
                                          .completionYear.value,
                                  onChanged: (newValue) {
                                    _authenticationController
                                        .completionYear.value = newValue;
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.5.h),
            Container(
              width: 100.w,
              decoration: BoxDecoration(
                border: Border.all(color: Constants.lightGreyBorderColor),
                borderRadius: BorderRadius.circular(1.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.5.w),
              child: TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                controller: signUpAboutMe,
                cursorColor: Constants.primaryColor,
                maxLines: null,
                minLines: 4,
                onChanged: (text) {},
                decoration: const InputDecoration(
                  hintText: 'About me',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            _authenticationController.registerLoading.value
                ? CommonButton.primaryFilledProgressButton(null, null)
                : InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (signUpPassword.text != signUpConfirmPassword.text) {
                          CustomToasts.errorToast(
                              context, "Password doesn't match..");
                        } else if(_authenticationController.selectedCourse.value == ""){
                          CustomToasts.errorToast(
                              context, "Course Not Selected..!!");
                        } else if(_authenticationController.selectedGender.value == ""){
                          CustomToasts.errorToast(
                              context, "Gender Not Selected..!!");
                        } else {
                          _authenticationController
                              .addStudentData(
                            uid: signUpUID.text.toUpperCase(),
                            name: signUpName.text,
                            password: signUpPassword.text,
                            aboutMe: signUpAboutMe.text,
                          )
                              .then((value) {
                            if (value == 1) {
                              CustomToasts.errorToast(
                                  context, "User Already Exists");
                            } else if (value == 2) {
                              CustomToasts.successToast(
                                  context, "User Registration Successful..!");

                              // Add UID, Course Code, Enrolled Year
                              Global.storageServices
                                  .setString(Constants.uid, signUpUID.text.toUpperCase());
                              Global.storageServices.setString(
                                  Constants.enrolledYear,
                                  _authenticationController.enrolledYear.value);
                              Global.storageServices.setString(
                                Constants.courseCode,
                                Functions.getCodeFromCourse(
                                  _authenticationController
                                      .selectedCourse.value,
                                ),
                              );
                              Functions.checkForFinalization().then((value) {
                                if (value == true) {
                                  Get.offAll(() => const FinalRegistrationFormScreen());
                                } else if (value == false) {
                                  Get.offAll(
                                      () => const UnFinalizedMainHomeScreen());
                                } else {
                                  CustomToasts.errorToast(context,
                                      "Unable to get your batch details. Try again later.");
                                }
                              });
                            } else {
                              CustomToasts.errorToast(context,
                                  "Error Signing Up! Please Try again Later..!!");
                            }
                          });
                        }
                      }
                    },
                    child:
                        CommonButton.primaryFilledButton(null, null, "Sign Up"),
                  ),
            SizedBox(height: 5.h),
          ],
        );
      }),
    );
  }
}