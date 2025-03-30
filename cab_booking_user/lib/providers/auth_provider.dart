import 'package:cab_booking_user/screens/auth/otp_screen.dart';
import 'package:cab_booking_user/screens/user_choice.dart'; // Import UserChoiceScreen
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider {
  final bool isLoading;

  AuthProvider({this.isLoading = false});

  AuthProvider copyWith({bool? isLoading}) {
    return AuthProvider(isLoading: isLoading ?? this.isLoading);
  }
}

class AuthNotifier extends StateNotifier<AuthProvider> {
  AuthNotifier() : super(AuthProvider());

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
    required String countryCode,
  }) async {
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$countryCode$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of OTP
          await FirebaseAuth.instance.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Phone number verified automatically!'),
            ),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          state = state.copyWith(isLoading: false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTPScreen with the verification ID
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => OTPScreen(
                    phoneNumber: '$countryCode$phoneNumber',
                    verificationId: verificationId,
                  ),
            ),
          ).then((_) {
            state = state.copyWith(isLoading: false);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      // Create a PhoneAuthCredential with the OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to UserChoiceScreen on successful verification
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => UserChoice()),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Show error message if OTP verification fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP, please try again.')),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

// Create a Riverpod provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthProvider>(
  (ref) => AuthNotifier(),
);
