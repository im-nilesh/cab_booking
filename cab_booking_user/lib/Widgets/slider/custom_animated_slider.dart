import 'package:cab_booking_user/screens/WelcomeScreen.dart'; // Import WelcomeScreen
import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomAnimatedSlider extends StatelessWidget {
  final int currentIndex;
  final int totalSlides;
  final VoidCallback onNext;

  const CustomAnimatedSlider({
    Key? key,
    required this.currentIndex,
    required this.totalSlides,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (currentIndex == totalSlides - 1) {
          // Navigate to WelcomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else {
          // Call the onNext callback to move to the next slide
          onNext();
        }
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Smooth Animated Circular Progress
            TweenAnimationBuilder<double>(
              duration: Duration(
                milliseconds: 700,
              ), // Smooth animation duration
              curve: Curves.easeInOut, // Makes it smoother
              tween: Tween<double>(
                begin: 0.0,
                end: ((currentIndex + 1) / totalSlides).clamp(0.0, 1.0),
              ),
              builder: (context, value, child) {
                return SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 4,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(greencolor),
                  ),
                );
              },
            ),

            // Conditional Rendering: "Go" Text or Arrow Icon
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child:
                    currentIndex == totalSlides - 1
                        ? Text(
                          "Go",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                        : Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 28,
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
