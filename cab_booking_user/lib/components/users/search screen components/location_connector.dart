import 'package:cab_booking_user/components/users/search%20screen%20components/dased_line_vertical_painter.dart';
import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';

class LocationConnector extends StatelessWidget {
  final bool isOriginFocused;
  final bool isDestinationFocused;

  const LocationConnector({
    super.key,
    required this.isOriginFocused,
    required this.isDestinationFocused,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, top: 12, bottom: 12),
      child: Column(
        children: [
          _buildCircle(isOriginFocused),
          const SizedBox(height: 45, child: DashedLineVerticalPainter()),
          _buildSquare(isDestinationFocused),
        ],
      ),
    );
  }

  Widget _buildCircle(bool isActive) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? greencolor : whiteColor, // FULL fill
        border: Border.all(color: whiteColor, width: 2),
      ),
    );
  }

  Widget _buildSquare(bool isActive) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? greencolor : whiteColor, // FULL fill
        border: Border.all(color: whiteColor, width: 2),
      ),
    );
  }
}
