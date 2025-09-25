import 'package:cab_booking_user/components/drivers/Vehical%20Screen%20Edit%20Components/custom_confirm_popup.dart';
import 'package:cab_booking_user/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          showDialog(
            context: context,
            builder:
                (context) => DocumentActionDialog(
                  title: 'Are you sure want to Sign out',
                  confirmText: 'Yes',
                  onConfirm: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      (route) => false,
                    );
                  },
                ),
          );
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
