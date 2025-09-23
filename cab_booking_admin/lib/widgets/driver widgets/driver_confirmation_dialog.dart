import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DriverConfirmationDialog extends StatelessWidget {
  final String rideId;
  final String driverUid;
  final String driverName;

  const DriverConfirmationDialog({
    super.key,
    required this.rideId,
    required this.driverUid,
    required this.driverName,
  });

  /// Generate a random 4-digit OTP
  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text("Confirm Assignment"),
      content: Text("Do you want to assign this ride to $driverName?"),
      actions: <Widget>[
        TextButton(
          child: Text("No", style: TextStyle(color: Colors.grey[800])),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Yes, Assign",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            try {
              final otp = generateOtp();

              await FirebaseFirestore.instance.collection('driverRides').add({
                'driverUid': driverUid,
                'rideId': rideId,
                'otp': otp,
                'createdAt': FieldValue.serverTimestamp(),
              });

              Navigator.of(context).pop(); // close confirmation
              Navigator.of(context).pop(); // close driver list
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error assigning driver: $e")),
              );
            }
          },
        ),
      ],
    );
  }
}
