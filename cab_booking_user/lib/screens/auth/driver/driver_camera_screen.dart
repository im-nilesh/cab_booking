import 'package:cab_booking_user/Widgets/camera/camera_widget.dart';
import 'package:cab_booking_user/Widgets/progress_bar/custom_progress_bar.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'driver_captured_photo_screen.dart'; // Import the captured photo screen

class DriverCameraScreen extends StatefulWidget {
  const DriverCameraScreen({Key? key}) : super(key: key);

  @override
  State<DriverCameraScreen> createState() => _DriverCameraScreenState();
}

class _DriverCameraScreenState extends State<DriverCameraScreen> {
  final GlobalKey<CameraWidgetState> _cameraKey =
      GlobalKey<CameraWidgetState>();

  void _capturePhoto() async {
    try {
      final photoPath = await _cameraKey.currentState?.capturePhoto();
      if (photoPath != null) {
        // Navigate to the next screen to display the captured photo
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => DriverCapturedPhotoScreen(photoPath: photoPath),
          ),
        );
      }
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

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
                child: CameraWidget(key: _cameraKey),
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
                    Text(
                      'Verify Your Identity',
                      style: GoogleFonts.outfit(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Put your face in the frame below',
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        color: grayColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Capture Button
              Center(
                child: GestureDetector(
                  onTap: _capturePhoto,
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
