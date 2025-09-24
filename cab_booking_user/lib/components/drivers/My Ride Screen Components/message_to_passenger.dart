import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageToPassengers extends StatelessWidget {
  final String message;

  const MessageToPassengers({Key? key, required this.message})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your message to passengers",
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.edit, size: 20, color: Colors.grey.shade700),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            message.isNotEmpty
                ? message
                : "No message added yet. Tap the edit icon to add one.",
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
