import 'package:cab_booking_admin/auth/auth_provider.dart';
import 'package:cab_booking_admin/screens/admin_home.dart';
import 'package:cab_booking_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            color: whiteColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: borderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Admin Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: greencolor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: greencolor,
                        foregroundColor: whiteColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: borderColor),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final user = await ref.read(
                            loginProvider({
                              'email': emailController.text.trim(),
                              'password': passwordController.text.trim(),
                            }).future,
                          );

                          if (user.email == 'admin@gmail.com') {
                            // ✅ Only allow admin
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AdminHome(),
                              ),
                            );
                          } else {
                            await FirebaseAuth.instance.signOut();
                            setState(
                              () =>
                                  errorMessage =
                                      'You are not authorized to access the admin panel.',
                            );
                          }
                        } catch (e) {
                          setState(() => errorMessage = e.toString());
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  if (errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
