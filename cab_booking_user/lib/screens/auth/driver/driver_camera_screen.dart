import 'package:cab_booking_user/Widgets/camera/camera_widget.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class DriverCameraScreen extends StatelessWidget {
  const DriverCameraScreen({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          // Camera preview inside the rounded rectangular container
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.0), // Rounded edges
              child: Container(
                width: 350.0, // Adjusted width
                height: 480.0, // Adjusted height
                child: CameraWidget(
                  onPhotoCaptured: (String photoPath) {
                    // Handle the captured photo
                    print('Photo captured at path: $photoPath');
                  },
                ),
              ),
            ),
          ),
          // Overlay UI
          Column(
            children: [
              // Progress Bar and Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomProgressBar(
                      currentStep: 1,
                      totalSteps: 2,
                      label: 'Basic Information',
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Verify Your Identity',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Put your face in the frame below',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Capture Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Handle capture button press
                  },
                  child: Container(
                    width: 90.0, // Outer circle size
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: greencolor, // Darker green outer border
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 75.0, // Middle circle size
                        height: 75.0,
                        decoration: BoxDecoration(
                          color: Colors.white, // White border
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 60.0, // Inner circle size
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: greencolor, // Lighter green center
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final double value;
  final Color backgroundColor;
  final Color progressColor;
  final double height;

  const CustomProgressIndicator({
    Key? key,
    required this.value,
    required this.backgroundColor,
    required this.progressColor,
    this.height = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: FractionallySizedBox(
        widthFactor: value,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: progressColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
