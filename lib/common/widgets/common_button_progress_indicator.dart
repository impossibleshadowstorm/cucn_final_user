import 'package:flutter/material.dart';

class CommonButtonProgressIndicator extends StatefulWidget {
  final double width;

  const CommonButtonProgressIndicator({
    super.key,
    required this.width,
  });

  @override
  State<CommonButtonProgressIndicator> createState() =>
      _CommonButtonProgressIndicatorState();
}

class _CommonButtonProgressIndicatorState
    extends State<CommonButtonProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: widget.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF941A49),
            Color(0xFF941A49),
            Color(0xFFEF578A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
