import 'package:cab_booking_user/Widgets/camera/camera_widget.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart'; // Import your custom progress bar
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class DriverCameraScreen extends StatelessWidget {
  const DriverCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          // Custom Camera Widget with required parameter
          CameraWidget(
            onPhotoCaptured: (String photoPath) {
              // Handle the captured photo
              print('Photo captured at path: $photoPath');
              // You can navigate to another screen or perform other actions here
            },
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
                      'Put your face in the oval below',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Oval Face Detection Area
              Center(
                child: Container(
                  width: 350.0,
                  height: 450.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(140.0),
                    border: Border.all(color: Colors.grey, width: 2.0),
                  ),
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
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4.0),
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
