import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';

class InfoDialog extends StatelessWidget {
  final Icon? icon; // Made icon nullable
  final String text;

  const InfoDialog({Key? key, this.icon, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: dialogBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 10)],
          Expanded(
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: dialogTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
