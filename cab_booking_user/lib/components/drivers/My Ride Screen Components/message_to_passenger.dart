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
          children: [
            Text(
              "Your message to passengers",
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(Icons.edit, size: 18, color: Colors.grey.shade600),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: Text(
            message.isNotEmpty ? message : "No message added yet",
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }
}
