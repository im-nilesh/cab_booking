import 'package:cab_booking_user/navigations/user_navigations.dart';
import 'package:cab_booking_user/navigations/driver_navigation.dart';
import 'package:cab_booking_user/screens/auth/driver/admin_rejected_profile.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_registration_complete_screen.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_profile_created_screen.dart';
import 'package:cab_booking_user/screens/auth/otp_screen.dart';
import 'package:cab_booking_user/screens/user_choice.dart';
import 'package:cab_booking_user/screens/welcome_screen.dart'; // Import WelcomeScreen
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Watches Firebase authentication state
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

/// Checks if logged-in user exists in "users" or "drivers"
final userRoleProvider = FutureProvider<String>((ref) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return "unauthenticated";

  final uid = user.uid;

  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  if (userDoc.exists) return "user";

  final driverDoc =
      await FirebaseFirestore.instance.collection('drivers').doc(uid).get();
  if (driverDoc.exists) return "driver";

  return "new_user"; // brand new, no entry in either collection
});

/// Watches only the driver's registration status in Firestore
final driverStatusProvider = StreamProvider<String>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream.value('unauthenticated');
  }

  return FirebaseFirestore.instance
      .collection('drivers')
      .doc(user.uid)
      .snapshots()
      .map((doc) {
        if (!doc.exists) return 'new_driver';
        final data = doc.data() as Map<String, dynamic>;
        final status = data['registration_status'] ?? 'incomplete';

        switch (status) {
          case 'pending_review': // driver uploaded docs, waiting for admin
            return 'pending';
          case 'approved': // admin approved
            return 'approved';
          case 'rejected':
            return 'rejected';
          case 'incomplete': // started but not finished
          default:
            return 'incomplete';
        }
      });
});

/// State for AuthProvider
class AuthProvider {
  final bool isLoading;
  AuthProvider({this.isLoading = false});

  AuthProvider copyWith({bool? isLoading}) {
    return AuthProvider(isLoading: isLoading ?? this.isLoading);
  }
}

/// Auth State Notifier
class AuthNotifier extends StateNotifier<AuthProvider> {
  AuthNotifier() : super(AuthProvider());

  /// Send OTP
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
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Phone number verified automatically!'),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          state = state.copyWith(isLoading: false);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Verification failed: ${e.message}')),
            );
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => OTPScreen(
                      phoneNumber: '$countryCode$phoneNumber',
                      verificationId: verificationId,
                    ),
              ),
            ).then((_) => state = state.copyWith(isLoading: false));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    }
  }

  /// Verify OTP
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
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const AuthGate()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid OTP, please try again.')),
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Save User Data in Firestore
  Future<bool> saveUserData({
    required String firstName,
    required String lastName,
    required String age,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'age': int.parse(age),
        'createdAt': FieldValue.serverTimestamp(),
        'role': 'user',
        'phone_number': user.phoneNumber,
      });
      return true;
    } catch (e) {
      debugPrint('Error saving user data: $e');
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthProvider>((ref) {
  return AuthNotifier();
});

/// AuthGate decides where user goes based on role + status
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return WelcomeScreen(); // Navigate to WelcomeScreen if not logged in
        }

        final roleAsync = ref.watch(userRoleProvider);
        return roleAsync.when(
          data: (role) {
            if (role == 'user') return const UserNavigation();
            if (role == 'driver') {
              final driverStatus = ref.watch(driverStatusProvider);
              return driverStatus.when(
                data: (status) {
                  switch (status) {
                    case 'new_driver':
                      return const UserChoice();
                    case 'incomplete':
                      return const DriverProfileCreatedScreen();
                    case 'pending':
                      return const DriverRegistrationCompleteScreen();
                    case 'rejected':
                      return const AdminRejectedProfileScreen();
                    case 'approved': // ✅ driver approved by admin
                      return const DriverNavigation();
                    default:
                      return const Scaffold(
                        body: Center(child: Text('Unknown driver status')),
                      );
                  }
                },
                loading:
                    () => const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                error:
                    (_, __) => const Scaffold(
                      body: Center(child: Text('Error fetching driver status')),
                    ),
              );
            }

            if (role == 'new_user') return const UserChoice();
            return const Scaffold(body: Center(child: Text('Unknown role')));
          },
          loading:
              () => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
          error:
              (_, __) => const Scaffold(
                body: Center(child: Text('Error fetching role')),
              ),
        );
      },
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (_, __) =>
              const Scaffold(body: Center(child: Text('Something went wrong'))),
    );
  }
}
