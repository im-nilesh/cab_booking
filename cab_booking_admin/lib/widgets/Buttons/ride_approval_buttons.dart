import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApprovalButtons extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const ApprovalButtons({
    super.key,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: onReject,
          icon: const Icon(Icons.close, color: Colors.white),
          label: Text('Reject', style: GoogleFonts.outfit(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: onApprove,
          icon: const Icon(Icons.check, color: Colors.white),
          label: Text(
            'Approve',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
