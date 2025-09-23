import 'package:cab_booking_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconPrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;

  const IconPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = greencolor,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: Icon(icon, color: iconColor),
      label: Text(
        text,
        style: GoogleFonts.inter(color: textColor, fontSize: 16),
      ),
    );
  }
}
