import 'package:cab_booking_user/Widgets/common/custom_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/Progress Indicator/circular_progess.dart';

import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/screens/user_choice.dart'; // Import UserChoiceScreen

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  OTPScreen({required this.phoneNumber, required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isLoading = false;

  void _verifyOTP() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Create a PhoneAuthCredential with the OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to UserChoiceScreen on successful verification
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserChoice()),
        (route) => false, // Remove all previous routes
      ).then((_) {
        // Stop showing the progress indicator after navigation
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      // Show error message if OTP verification fails
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid OTP, please try again.')));

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: blackColor),
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
                Text(
                  'Enter the 6-digit code sent to you over ${widget.phoneNumber}',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),

                // Use CustomOtpInput here
                Center(child: CustomOtpInput(otpController: _otpController)),

                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Handle Resend OTP
                  },
                  child: Text(
                    "Didn't receive the code? Resend",
                    style: GoogleFonts.outfit(
                      color: blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Confirm',
                    onPressed: isLoading ? () {} : _verifyOTP,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if (isLoading)
          const CustomProgressIndicator(), // Show progress indicator when loading
      ],
    );
  }
}
