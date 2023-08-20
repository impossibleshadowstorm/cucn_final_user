import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uicn/controllers/main_animation_controller.dart';
import 'package:uicn/views/app_lock/application_locked_screen.dart';

class LockAnimationScreen extends StatefulWidget {
  const LockAnimationScreen({super.key});

  @override
  State<LockAnimationScreen> createState() => _LockAnimationScreenState();
}

class _LockAnimationScreenState extends State<LockAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(
        milliseconds: 2250); // Set the animation duration (50% slower)
    _controller.forward().whenComplete(() {
      // Animation has completed playing once
      Get.offAll(
        () => const ApplicationLockedScreen(),
        transition: Transition.zoom,
        duration: const Duration(seconds: 2),
      );
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie_jsons/lock.json",
          repeat: false,
          controller: _controller,
        ),
      ),
    );
  }
}
