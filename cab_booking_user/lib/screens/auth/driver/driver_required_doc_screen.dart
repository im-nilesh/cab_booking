import 'package:cab_booking_user/Widgets/button/custom_upload_button.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';

class DriverRequiredDocScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24),
            CustomUploadButton(
              title: "Driving License",
              onPressed: () {
                // Handle file upload
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of vehicle’s number plate",
              onPressed: () {
                // Handle file upload
              },
            ),
            SizedBox(height: 16),
            CustomUploadButton(
              title: "Image of RC",
              onPressed: () {
                // Handle file upload
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: null, // Disable the button for now
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Next"),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
