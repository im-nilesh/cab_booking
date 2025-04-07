import 'package:cab_booking_user/screens/auth/driver/admin_rejected_profile.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverRegistrationCompleteScreen extends StatelessWidget {
  const DriverRegistrationCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: tickbackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: greencolor,
                  size: 120, // Increased size for better visibility
                  weight: 900, // Adjusted weight for thickness (if supported)
                ),
              ),
            ),
            const Text(
              'Registration Completed!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: dialogBackgroundColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Your request is sent for approval and you will be notified shortly',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: dialogTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
