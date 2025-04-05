import 'package:cab_booking_user/providers/driver_registration_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firebase Firestore
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/Widgets/textfield/custom_text_field.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_age_collect_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';

class DriverNameCollectScreen extends ConsumerStatefulWidget {
  const DriverNameCollectScreen({super.key});

  @override
  ConsumerState<DriverNameCollectScreen> createState() =>
      _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState
    extends ConsumerState<DriverNameCollectScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateFields);
    _lastNameController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled =
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty;
    });
  }

  void _handleNextButtonPress(BuildContext context, WidgetRef ref) async {
    // Call the provider to save details
    await ref
        .read(driverRegistrationProvider)
        .saveDriverDetails(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          context: context,
        );

    // Navigate to the next screen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DriverAgeCollectScreen()),
    );
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_validateFields);
    _lastNameController.removeListener(_validateFields);
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
            // Progress Bar
            CustomProgressBar(
              currentStep: 1,
              totalSteps: 2,
              label: 'Basic Information',
            ),
            const SizedBox(height: 30),

            // Title
            Text(
              "What's your name?",
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),

            // First Name Field
            CustomTextField(
              controller: _firstNameController,
              hintText: 'First Name',
            ),
            const SizedBox(height: 10),

            // Last Name Field
            CustomTextField(
              controller: _lastNameController,
              hintText: 'Last Name',
            ),
            const Spacer(),

            // Next Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    onPressed:
                        _isButtonEnabled
                            ? () {
                              _handleNextButtonPress(context, ref);
                            }
                            : () {}, // Disabled state
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
