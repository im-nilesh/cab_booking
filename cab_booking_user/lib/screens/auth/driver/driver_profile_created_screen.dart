import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/utils/constants.dart';

class DriverProfileCreatedScreen extends StatelessWidget {
  const DriverProfileCreatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CustomProgressBar(
                currentStep: 1,
                totalSteps: 2,
                label: 'Basic Information',
              ),
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 135,
                backgroundColor: avatarborderColor,
                child: CircleAvatar(
                  radius: 127,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage(
                      'assets/images/profile_picture.png',
                    ), // Replace with your image asset
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your profile is created!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'To host a ride, you must register your vehicle on this platform.\nAll it takes is 3 easy steps!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Start',
                onPressed: () {
                  // Navigate to the next screen
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
