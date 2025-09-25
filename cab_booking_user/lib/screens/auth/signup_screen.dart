// lib/screens/auth/signup_screen.dart
import 'package:cab_booking_user/navigations/user_navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/providers/auth_provider.dart';
import 'package:cab_booking_user/Widgets/Progress%20Indicator/circular_progess.dart';
import 'package:cab_booking_user/Widgets/common/custom_phoneno_textfield.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:country_picker/country_picker.dart';
import 'package:cab_booking_user/utils/constants.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  String _selectedCountryCode = '+91';
  String _selectedCountryFlag = '🇮🇳';
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the auth state (type: AuthProviderState)
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: blackColor),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Sign Up', style: TextStyle(color: blackColor)),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Enter your mobile number',
                  style: TextStyle(
                    fontSize: 24,
                    color: blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _selectedCountryCode = '+${country.phoneCode}';
                              _selectedCountryFlag = country.flagEmoji;
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Text(
                              _selectedCountryFlag,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomPhonenoTextfield(
                        phoneController: _phoneController,
                        selectedCountryCode: _selectedCountryCode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Continue',
                    onPressed:
                        authState.isLoading
                            ? () {}
                            : () {
                              authNotifier.sendOTP(
                                context: context,
                                phoneNumber: _phoneController.text.trim(),
                                countryCode: _selectedCountryCode,
                              );
                            },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (authState.isLoading) const Center(child: CustomProgressIndicator()),
      ],
    );
  }
}
