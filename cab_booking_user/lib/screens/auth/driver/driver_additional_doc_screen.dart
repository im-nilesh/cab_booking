import 'dart:io';
import 'package:cab_booking_user/Widgets/Progress%20Indicator/circular_progess.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_registration_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/button/custom_upload_button.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';

class DriverAdditionalDocScreen extends ConsumerStatefulWidget {
  const DriverAdditionalDocScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DriverAdditionalDocScreen> createState() =>
      _DriverAdditionalDocScreenState();
}

class _DriverAdditionalDocScreenState
    extends ConsumerState<DriverAdditionalDocScreen> {
  File? insuranceCopyFile;
  File? pollutionCertificateFile;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(driverRegistrationProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomProgressBar(
                  currentStep: 2,
                  totalSteps: 2,
                  label: 'Vehicle Registration',
                ),
                const SizedBox(height: 30),
                const Text(
                  'Upload additional documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                CustomUploadButton(
                  title: 'Insurance Copy',
                  onFilePicked: (file) {
                    setState(() {
                      insuranceCopyFile = file;
                    });
                  },
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                CustomUploadButton(
                  title: 'Pollution Check Certificate',
                  onFilePicked: (file) {
                    setState(() {
                      pollutionCertificateFile = file;
                    });
                  },
                  onPressed: () {},
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
                          if (insuranceCopyFile == null ||
                              pollutionCertificateFile == null) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please upload all required documents.',
                                  ),
                                ),
                              );
                            }
                            return;
                          }
                          await ref
                              .read(driverRegistrationProvider)
                              .uploadAdditionalDriverDocuments(
                                insuranceCopyFile: insuranceCopyFile,
                                pollutionCertificateFile:
                                    pollutionCertificateFile,
                                context: context, // Pass context here
                              );
                          if (mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const DriverRegistrationCompleteScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if (provider.isUploading) const CustomProgressIndicator(),
      ],
    );
  }
}
