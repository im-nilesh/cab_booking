import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';

class DashedLineVerticalPainter extends StatelessWidget {
  const DashedLineVerticalPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      child: CustomPaint(painter: _DashedLinePainter()),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 7, dashSpace = 3, startY = 0;
    final paint =
        Paint()
          ..color = whiteColor
          ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
