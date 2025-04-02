import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';

class CustomProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String label;

  const CustomProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Added for alignment
            children: [
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: greencolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$currentStep of $totalSteps',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                // Ensures the Column takes available space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Added for alignment
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade300,
                        color: greencolor,
                        minHeight: 10, // Adjusted height to match the design
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
