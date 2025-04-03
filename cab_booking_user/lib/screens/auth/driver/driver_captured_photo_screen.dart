import 'dart:io';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart'; // Use your custom progress bar
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriverCapturedPhotoScreen extends StatelessWidget {
  final String photoPath;

  const DriverCapturedPhotoScreen({Key? key, required this.photoPath})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          // Custom Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomProgressBar(
              currentStep: 1,
              totalSteps: 2,
              label: 'Basic Information',
            ),
          ),
          const SizedBox(height: 15.0),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Picture',
                style: GoogleFonts.outfit(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),

          // Captured Photo
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.0), // Rounded edges
              child: Container(
                width: 350.0, // Adjusted width
                height: 480.0, // Adjusted height
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2.0),
                ),
                child: Image.file(File(photoPath), fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Upload and Retake Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: PrimaryButton(
                    text: 'Upload',
                    onPressed: () {
                      // Handle upload action
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Go back to retake photo
                  },
                  child: Text(
                    'Retake',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      color: grayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
