import 'package:cab_booking_user/Widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
// Import the reusable button widget

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Illustration Image
            Image.asset(
              'assets/images/Welcome.png', // Replace with your image path
              height: 250,
            ),
            SizedBox(height: 30),

            // Welcome Text
            Text(
              'Welcome to eTaxxi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Have a better sharing experience',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Sign Up Button
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                // Navigate to Sign Up Screen
              },
            ),
            SizedBox(height: 20),

            // Login Text
            GestureDetector(
              onTap: () {
                // Navigate to Login Screen
              },
              child: Text(
                'Already an user? Login',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
