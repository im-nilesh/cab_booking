import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminRejectedProfileScreen extends StatelessWidget {
  const AdminRejectedProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 220), // Adjusted top spacing
            // Illustration
            Image.asset(
              'assets/images/Frame34845.png', // Replace with your asset path
              height: 250,
            ),
            const SizedBox(height: 30),
            // Rejection Message
            Text(
              'We are sorry to say',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Driver application is rejected\nDocuments did not meet requirements',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: blackColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 30),
            // Customer Care Info
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: dialogBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'To know more contact our customer care',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, color: blackColor, size: 16),
                      const SizedBox(width: 10),
                      Text(
                        '6311111111',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Try Again Button
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              child: PrimaryButton(
                text: 'Try again',
                onPressed: () {
                  // Handle retry action
                },
                backgroundColor: greencolor,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(height: 60), // Adjusted bottom spacing
          ],
        ),
      ),
    );
  }
}
