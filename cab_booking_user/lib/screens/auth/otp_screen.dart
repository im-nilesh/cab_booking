import 'package:cab_booking_user/Widgets/common/custom_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/Progress Indicator/circular_progess.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/providers/auth_provider.dart';

class OTPScreen extends ConsumerWidget {
  final String phoneNumber;
  final String verificationId;

  OTPScreen({required this.phoneNumber, required this.verificationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    final TextEditingController _otpController = TextEditingController();

    // Reset isLoading to false when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState.isLoading) {
        authNotifier.state = authNotifier.state.copyWith(isLoading: false);
      }
    });

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
                  'Enter the 6-digit code sent to you over $phoneNumber',
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
                    onPressed:
                        authState.isLoading
                            ? () {}
                            : () {
                              authNotifier.verifyOTP(
                                context: context,
                                verificationId: verificationId,
                                otp: _otpController.text.trim(),
                              );
                            },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if (authState.isLoading)
          const CustomProgressIndicator(), // Show progress indicator when loading
      ],
    );
  }
}
