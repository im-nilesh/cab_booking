import 'package:cab_booking_user/screens/auth/otp_screen.dart';
import 'package:cab_booking_user/screens/user_choice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to UserChoiceScreen on successful verification
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserChoice()),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP, please try again.')),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  // This method now returns a boolean to indicate success or failure.
  Future<bool> saveUserData({
    required String firstName,
    required String lastName,
    required String age,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      }
      final uid = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'age': int.parse(age),
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'user',
        'phone_number': user.phoneNumber,
      });

      return true; // Return true on successful save.
    } catch (e) {
      print('Error saving user data: $e');
      return false; // Return false on error.
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthProvider>(
  (ref) => AuthNotifier(),
);
