import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../controllers/unfinalized/unfinalized_main_application_controller.dart';
import '../../../utils/constants.dart';

class UnFinalizedMainHomeScreen extends StatefulWidget {
  const UnFinalizedMainHomeScreen({super.key});

  @override
  State<UnFinalizedMainHomeScreen> createState() =>
      _UnFinalizedMainHomeScreenState();
}

class _UnFinalizedMainHomeScreenState extends State<UnFinalizedMainHomeScreen> {
  final UnFinalizedMainApplicationController
      _unFinalizedMainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _unFinalizedMainApplicationController.bottomNavPages[
          _unFinalizedMainApplicationController.bottomPageIdx.value]),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              right: 15.0, left: 15.0, bottom: 15.0, top: 10),
          child: GNav(
            tabs: _unFinalizedMainApplicationController.bottomNavIconsList,
            padding: const EdgeInsets.all(12.0),
            gap: 10.0,
            onTabChange: (index) {
              _unFinalizedMainApplicationController.bottomPageIdx.value = index;
            },
            backgroundColor: Colors.white,
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: Constants.primaryColor,
          ),
        ),
      ),
    );
  }
}
