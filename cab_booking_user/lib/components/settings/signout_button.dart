// lib/widgets/settings/sign_out_button.dart
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color lightRedBg = const Color(0xffFEF3F2);
    final Color darkRed = const Color(0xffD92D20);

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Handle sign out
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: lightRedBg,
          foregroundColor: darkRed,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: darkRed),
          ),
        ),
        child: const Text(
          "Sign out",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
