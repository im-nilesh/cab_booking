import 'package:cab_booking_user/screens/auth/driver/driver_registration_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/button/custom_upload_button.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';

class DriverAdditionalDocScreen extends StatelessWidget {
  const DriverAdditionalDocScreen({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomProgressBar(
              currentStep: 2,
              totalSteps: 2,
              label: 'Vehicle Registration',
            ),
            const SizedBox(height: 30),
            const Text(
              'Upload additional documents',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            CustomUploadButton(
              title: 'Insurance Copy',
              onPressed: () {
                // Handle upload action for Insurance Copy
              },
            ),
            const SizedBox(height: 20),
            CustomUploadButton(
              title: 'Pollution Check Certificate',
              onPressed: () {
                // Handle upload action for Pollution Check Certificate
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder:
                              (context) => DriverRegistrationCompleteScreen(),
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
