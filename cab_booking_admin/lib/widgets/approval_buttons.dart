import 'package:flutter/material.dart';

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
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          tooltip: 'Reject Registration',
          onPressed: onReject,
        ),
        IconButton(
          icon: const Icon(Icons.check, color: Colors.green),
          tooltip: 'Approve Registration',
          onPressed: onApprove,
        ),
      ],
    );
  }
}
