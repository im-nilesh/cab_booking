// lib/screens/auth/driver/driver_age_collect_screen.dart

import 'package:cab_booking_user/providers/driver_registration_provider.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/Widgets/textfield/custom_text_field.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_selfie_instruction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';

class DriverAgeCollectScreen extends ConsumerStatefulWidget {
  const DriverAgeCollectScreen({super.key});

  @override
  ConsumerState<DriverAgeCollectScreen> createState() =>
      _DriverRegistrationScreen2State();
}

class _DriverRegistrationScreen2State
    extends ConsumerState<DriverAgeCollectScreen> {
  final TextEditingController _ageController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _ageController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isButtonEnabled = _ageController.text.isNotEmpty;
    });
  }

  Future<void> _handleNextButtonPress(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final age = int.tryParse(_ageController.text);
      if (age == null || age <= 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a valid age')),
          );
        }
        return;
      }
      await ref
          .read(driverRegistrationProvider)
          .updateDriverAge(age: age, context: context);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DriverSelfieInstructionScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update age: $e')));
      }
    }
  }

  @override
  void dispose() {
    _ageController.removeListener(_validateFields);
    _ageController.dispose();
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
            const CustomProgressBar(
              currentStep: 2,
              totalSteps: 2,
              label: 'Basic Information',
            ),
            const SizedBox(height: 30),
            Text(
              "What's your age?",
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: _ageController, hintText: 'Age'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    // Corrected: Pass a non-nullable function in both cases
                    onPressed:
                        _isButtonEnabled
                            ? () => _handleNextButtonPress(context, ref)
                            : () {},
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
