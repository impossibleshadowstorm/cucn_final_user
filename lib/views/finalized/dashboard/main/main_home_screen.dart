import 'package:uicn/controllers/main_application_controller.dart';
import 'package:uicn/utils/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _mainApplicationController
            .finalizedBottomNavScreens[_mainApplicationController.finalizedBottomNavIdx.value],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        onTap: (index) {
          _mainApplicationController.finalizedBottomNavIdx.value = index;
        },
        buttonBackgroundColor: Constants.primaryDarkBlueColor,
        index: _mainApplicationController.finalizedBottomNavIdx.value,
        color: Constants.primaryColor,
        items: const [
          Icon(
            Icons.home_filled,
            color: Colors.white,
          ),
          Icon(
            Icons.notification_add,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
