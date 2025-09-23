// lib/provider/driver_provider.dart
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driverAssignmentProvider = Provider<DriverAssignmentProvider>(
  (ref) => DriverAssignmentProvider(),
);

class DriverAssignmentProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate a 4-digit OTP
  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString();
  }

  /// Assign a driver to a ride
  Future<void> assignDriver({
    required String rideId,
    required String driverUid,
    required String driverName,
  }) async {
    final otp = generateOtp();

    // 1️⃣ Create new entry in driverRides
    await _firestore.collection('driverRides').add({
      'driverUid': driverUid,
      'rideId': rideId,
      'otp': otp,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 2️⃣ Update rides collection
    await _firestore.collection('rides').doc(rideId).update({
      'ride_status': 'assigned',
      'assigned_driver': {'uid': driverUid, 'name': driverName},
      'otp': otp,
    });
  }
}
