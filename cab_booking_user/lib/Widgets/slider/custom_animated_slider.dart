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
      onTap: onNext,
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
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: (currentIndex + 1) / totalSlides,
                strokeWidth: 4,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.green.shade700,
                ),
              ),
            ),
            currentIndex == totalSlides - 1
                ? Text(
                  "Go",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
                : Icon(Icons.arrow_forward, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}
