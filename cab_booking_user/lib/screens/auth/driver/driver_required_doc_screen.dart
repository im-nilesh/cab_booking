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
            _buildUploadButton("Driving License"),
            SizedBox(height: 16),
            _buildUploadButton("Image of vehicle’s number plate"),
            SizedBox(height: 16),
            _buildUploadButton("Image of RC"),
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

  Widget _buildUploadButton(String title) {
    return OutlinedButton.icon(
      onPressed: () {
        // Handle file upload
      },
      icon: Icon(Icons.upload_file, color: Colors.green),
      label: Text(title, style: TextStyle(color: Colors.green)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.green),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(double.infinity, 48),
      ),
    );
  }
}
