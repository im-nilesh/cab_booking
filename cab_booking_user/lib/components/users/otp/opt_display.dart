import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpDisplay extends StatelessWidget {
  final String otp;

  const OtpDisplay({super.key, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'OTP: ',
          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...otp
            .split('')
            .map(
              (digit) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    digit,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
