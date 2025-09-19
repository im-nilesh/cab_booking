import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode; // 👈 add this

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.focusNode, // 👈 add this
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode, // 👈 use it here
      decoration: InputDecoration(
        hintText: '  $hintText',
        hintStyle: GoogleFonts.outfit(color: hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: whiteColor,
      ),
    );
  }
}
