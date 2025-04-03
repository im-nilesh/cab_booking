import 'package:cab_booking_user/Widgets/info_box/info_dialog.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';

class DriverSelfieInstructionScreen extends StatelessWidget {
  const DriverSelfieInstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            CustomProgressBar(
              currentStep: 1,
              totalSteps: 2,
              label: 'Basic Information',
            ),
            const SizedBox(height: 30),

            // Title
            Text(
              'Take a Selfie!',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              'We will compare the photo in your documents with your selfie to confirm your identity',
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: hintColor,
              ),
            ),
            const SizedBox(height: 30),

            // Selfie Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/image11.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please ensure your eyes and ears are clearly visible',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'It’s advisable to take the photograph against a white background',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Reusable Information Box
            InfoDialog(
              icon: const Icon(Icons.info, color: greencolor),
              text:
                  'The data you share will be encrypted, stored securely, and only used to verify your identity',
            ),
            const SizedBox(height: 30),
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DriverCameraScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
