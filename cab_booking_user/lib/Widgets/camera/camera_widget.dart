import 'package:cab_booking_user/screens/auth/driver/driver_captured_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraWidget extends StatefulWidget {
  final Function(String) onPhotoCaptured;

  const CameraWidget({Key? key, required this.onPhotoCaptured})
    : super(key: key);

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _cameraController = CameraController(frontCamera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _capturePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      widget.onPhotoCaptured(image.path);

      // Navigate to the new screen with the captured image
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => DriverCapturedPhotoScreen(photoPath: image.path),
        ),
      );
    } catch (e) {
      print('Error capturing photo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              // Camera preview restricted to oval space
              ClipPath(
                clipper: OvalClipper(),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_cameraController),
                ),
              ),
              // Overlay for the oval border
              Center(
                child: Container(
                  width: 250.0,
                  height: 350.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(200.0),
                  ),
                ),
              ),
              // Capture button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: GestureDetector(
                    onTap: _capturePhoto,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 4.0),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class OvalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    const ovalWidth = 250.0;
    const ovalHeight = 350.0;

    path.addOval(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: ovalWidth,
        height: ovalHeight,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
