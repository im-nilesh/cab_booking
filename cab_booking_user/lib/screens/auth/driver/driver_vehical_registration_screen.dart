import 'package:cab_booking_user/screens/auth/driver/driver_required_doc_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';

class DriverVehicleRegistrationScreen extends ConsumerWidget {
  const DriverVehicleRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController vehicleNumberController =
        TextEditingController();

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomProgressBar(
              currentStep: 2,
              totalSteps: 2,
              label: 'Vehicle Registration',
            ),
            const SizedBox(height: 40),
            Text(
              'Register Your Vehicle in\n3 easy steps!',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: vehicleNumberController,
              decoration: InputDecoration(
                hintText: 'Enter vehicle number',
                hintStyle: GoogleFonts.outfit(fontSize: 16, color: hintColor),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: borderColor),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    onPressed: () async {
                      final vehicleNumber = vehicleNumberController.text.trim();

                      if (vehicleNumber.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a vehicle number'),
                          ),
                        );
                        return;
                      }

                      // Save the vehicle number to Firebase
                      await ref
                          .read(driverRegistrationProvider)
                          .saveVehicleNumber(
                            vehicleNumber: vehicleNumber,
                            context: context,
                          );

                      // Navigate to the next screen or show success
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const DriverRequiredDocScreen(), // Replace with the next screen
                        ),
                      );
                    },
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
