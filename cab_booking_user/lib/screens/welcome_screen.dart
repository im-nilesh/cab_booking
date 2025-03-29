import 'package:cab_booking_user/Widgets/button/custom_button.dart';

import 'package:cab_booking_user/screens/signup_screen.dart'; // Import SignUpScreen
import 'package:flutter/material.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SignUpScreen(), // Replace with your SignUpScreen
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            // Login Text
            GestureDetector(
              onTap: () {
                // Navigate to Login Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SignUpScreen(), // Replace with your SignInScreen
                  ),
                );
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
