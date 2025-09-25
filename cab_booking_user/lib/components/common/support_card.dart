import 'package:flutter/material.dart';

class CustomerSupportCard extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onCall;

  const CustomerSupportCard({
    super.key,
    required this.phoneNumber,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardBorderColor = Colors.grey.shade300;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cardBorderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phone number
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          // Call icon button
          GestureDetector(
            onTap: onCall,
            child: const CircleAvatar(
              backgroundColor: Colors.green,
              radius: 18,
              child: Icon(Icons.call, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
