import 'dart:io';
import 'package:cab_booking_user/Widgets/button/custom_upload_button.dart';
import 'package:cab_booking_user/Widgets/button/primary_button.dart';
import 'package:cab_booking_user/providers/driver_registration_provider.dart';
import 'package:cab_booking_user/screens/auth/driver/driver_additional_doc_screen.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriverRequiredDocScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<DriverRequiredDocScreen> createState() =>
      _DriverRequiredDocScreenState();
}

class _DriverRequiredDocScreenState
    extends ConsumerState<DriverRequiredDocScreen> {
  File? drivingLicenseFile;
  File? vehicleNumberPlateFile;
  File? rcFile;

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
              onPressed: () {},
              onFilePicked: (file) {
                setState(() {
                  drivingLicenseFile = file;
                });
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of vehicle’s number plate",
              onPressed: () {},
              onFilePicked: (file) {
                setState(() {
                  vehicleNumberPlateFile = file;
                });
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of RC",
              onPressed: () {},
              onFilePicked: (file) {
                setState(() {
                  rcFile = file;
                });
              },
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
                      await ref
                          .read(driverRegistrationProvider)
                          .uploadDriverDocuments(
                            drivingLicenseFile: drivingLicenseFile,
                            vehicleNumberPlateFile: vehicleNumberPlateFile,
                            rcFile: rcFile,
                            context: context,
                          );
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
