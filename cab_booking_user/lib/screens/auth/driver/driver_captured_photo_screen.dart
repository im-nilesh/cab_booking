// lib/screens/auth/driver/driver_captured_photo_screen.dart

import 'dart:io';
import 'package:cab_booking_user/Widgets/Progress%20Indicator/circular_progess.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_profile_created_screen.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';

class DriverCapturedPhotoScreen extends ConsumerStatefulWidget {
  final String photoPath;
  const DriverCapturedPhotoScreen({Key? key, required this.photoPath})
    : super(key: key);

  @override
  ConsumerState<DriverCapturedPhotoScreen> createState() =>
      _DriverCapturedPhotoScreenState();
}

class _DriverCapturedPhotoScreenState
    extends ConsumerState<DriverCapturedPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(driverRegistrationProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomProgressBar(
                  currentStep: 1,
                  totalSteps: 2,
                  label: 'Basic Information',
                ),
              ),
              const SizedBox(height: 15.0),
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
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(120.0),
                  child: Container(
                    width: 350.0,
                    height: 480.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                    ),
                    child: Image.file(
                      File(widget.photoPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: PrimaryButton(
                        text: 'Upload',
                        onPressed: () async {
                          await ref
                              .read(driverRegistrationProvider)
                              .uploadDriverPhoto(
                                photoPath: widget.photoPath,
                                context: context, // ADDED 'context' HERE
                              );
                          if (mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const DriverProfileCreatedScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
          if (provider.isUploading) const CustomProgressIndicator(),
        ],
      ),
    );
  }
}
