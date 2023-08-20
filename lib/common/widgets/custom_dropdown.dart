import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final String hintText;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
  });

  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedValue,
      underline: const SizedBox(),
      hint: Text(
        widget.hintText,
        style: GoogleFonts.poppins(
          color: Colors.black,
        ),
      ),
      isDense: true,
      isExpanded: true,
      style: GoogleFonts.poppins(
        color: Colors.black,
      ),
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // setState(() {
        widget.onChanged(newValue!);
        // });
      },
    );
  }
}
