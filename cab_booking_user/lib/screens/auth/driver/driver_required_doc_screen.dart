import 'package:cab_booking_user/Widgets/button/custom_upload_button.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_additional_doc_screen.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverRequiredDocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            CustomProgressBar(
              currentStep: 2,
              totalSteps: 2,
              label: "Vehicle Registration",
            ),
            SizedBox(height: 24),
            Text(
              "Upload the Required documents",
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            SizedBox(height: 24),
            CustomUploadButton(
              title: "Driving License",
              onFileSelected: () {
                print("File selected!");
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of vehicle’s number plate",
              onFileSelected: () {
                print("File selected!");
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of RC",
              onFileSelected: () {
                print("File selected!");
              },
            ),
            SizedBox(height: 16),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DriverAdditionalDocScreen(),
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
