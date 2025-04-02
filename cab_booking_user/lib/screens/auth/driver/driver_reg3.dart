import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/textfield/custom_text_field.dart';

class DriverRegistrationStep3 extends StatelessWidget {
  const DriverRegistrationStep3({super.key});

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
            ProgressBar(
              currentStep: 1,
              totalSteps: 2,
              label: 'Basic Information',
            ),
            const SizedBox(height: 30),

            // Title
            Text(
              'Take a Selfie!',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w500,
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
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 80, color: Colors.grey),
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
            const SizedBox(height: 30),

            // Information Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info, color: greencolor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'The data you share will be encrypted, stored securely, and only used to verify your identity',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.07,
              child: PrimaryButton(
                text: 'Continue',
                onPressed: () {
                  // Navigate to the next screen
                  Navigator.pushNamed(context, '/next_screen');
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
