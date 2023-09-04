import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../controllers/main_application_controller.dart';
import '../../../utils/constants.dart';
import '../drawer_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainApplicationController _mainApplicationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerScreen(),
        Obx(() {
          return AnimatedContainer(
            transform: Matrix4.translationValues(
                _mainApplicationController.xOffset.value,
                _mainApplicationController.yOffset.value,
                0)
              ..scale(
                  _mainApplicationController.isDrawerOpen.value ? 0.85 : 1.00)
              ..rotateZ(
                  _mainApplicationController.isDrawerOpen.value ? -50 : 0),
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: _mainApplicationController.isDrawerOpen.value
                  ? BorderRadius.circular(40)
                  : BorderRadius.circular(0),
            ),
            child: Scaffold(
              body: Obx(() => _mainApplicationController.bottomNavScreens[
                  _mainApplicationController.bottomNavIdx.value]),
              bottomNavigationBar: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15.0, bottom: 15.0, top: 10),
                  child: Obx(() {
                    return GNav(
                      tabs: _mainApplicationController.bottomNavIconsList,
                      padding: const EdgeInsets.all(12.0),
                      gap: 10.0,
                      onTabChange: (index) {
                        _mainApplicationController.bottomNavIdx.value = index;
                      },
                      selectedIndex:
                          _mainApplicationController.bottomNavIdx.value,
                      backgroundColor: Colors.white,
                      color: Colors.black,
                      activeColor: Colors.white,
                      tabBackgroundColor: Constants.primaryColor,
                    );
                  }),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
