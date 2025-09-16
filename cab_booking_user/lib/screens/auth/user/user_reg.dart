import 'package:cab_booking_user/navigations/user_navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/providers/auth_provider.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/textfield/custom_text_field.dart';

class UserRegistrationScreen extends ConsumerStatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  ConsumerState<UserRegistrationScreen> createState() =>
      _UserRegistrationScreenState();
}

class _UserRegistrationScreenState
    extends ConsumerState<UserRegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            Text(
              'Basic Information',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "What's your name?",
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _firstNameController,
              hintText: 'First Name',
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _lastNameController,
              hintText: 'Last Name',
            ),
            const SizedBox(height: 20),
            Text(
              "What's your age?",
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _ageController,
              hintText: 'Age',
              keyboardType: TextInputType.number,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Done',
                    onPressed: () async {
                      final firstName = _firstNameController.text.trim();
                      final lastName = _lastNameController.text.trim();
                      final age = _ageController.text.trim();

                      if (firstName.isEmpty ||
                          lastName.isEmpty ||
                          age.isEmpty) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill out all fields'),
                            ),
                          );
                        }
                        return;
                      }

                      // Show loading indicator
                      ref.read(authProvider.notifier).state = ref
                          .read(authProvider.notifier)
                          .state
                          .copyWith(isLoading: true);

                      final success = await ref
                          .read(authProvider.notifier)
                          .saveUserData(
                            firstName: firstName,
                            lastName: lastName,
                            age: age,
                          );

                      // Hide loading indicator
                      if (mounted) {
                        ref.read(authProvider.notifier).state = ref
                            .read(authProvider.notifier)
                            .state
                            .copyWith(isLoading: false);
                      }

                      if (success) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registration Successful!'),
                            ),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const UserNavigation(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Registration Failed. Please try again.',
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
