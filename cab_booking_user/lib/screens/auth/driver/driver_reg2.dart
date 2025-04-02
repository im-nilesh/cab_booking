import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar';
import 'package:cab_booking_user/Widgets/textfield/custom_text_field.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_reg3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';

class DriverRegistrationScreen2 extends StatefulWidget {
  const DriverRegistrationScreen2({super.key});

  @override
  State<DriverRegistrationScreen2> createState() =>
      _DriverRegistrationScreen2State();
}

class _DriverRegistrationScreen2State extends State<DriverRegistrationScreen2> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

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
              "What's your name?",
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),

            // First Name Field
            CustomTextField(controller: _firstNameController, hintText: ' Age'),
            const SizedBox(height: 10),

            // Last Name Field

            // Next Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    onPressed: () {
                      // Navigate to the next screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const DriverRegistrationStep3(), // Replace with your next screen
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
