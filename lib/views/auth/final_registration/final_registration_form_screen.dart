import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FinalRegistrationFormScreen extends StatefulWidget {
  const FinalRegistrationFormScreen({super.key});

  @override
  State<FinalRegistrationFormScreen> createState() =>
      _FinalRegistrationFormScreenState();
}

class _FinalRegistrationFormScreenState
    extends State<FinalRegistrationFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Registration",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
