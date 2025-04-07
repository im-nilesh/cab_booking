import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUploadButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomUploadButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.upload_file, color: greencolor),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              color: greencolor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: uploadButtonborderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 65), // Adjusted height
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
