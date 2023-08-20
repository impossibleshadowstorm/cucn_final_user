import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  final String errorText;

  const ErrorScreen({
    super.key,
    required this.errorText,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.errorText),
      ),
    );
  }
}
