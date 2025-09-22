import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailureButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color textColor;

  const FailureButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(color: textColor, fontSize: 16),
      ),
    );
  }
}
