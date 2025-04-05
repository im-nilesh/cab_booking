import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driverRegistrationProvider = Provider(
  (ref) => DriverRegistrationProvider(),
);

class DriverRegistrationProvider with ChangeNotifier {
  Future<void> saveDriverDetails({
    required String firstName,
    required String lastName,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not authenticated");
      }

      // Save data to Firestore
      await FirebaseFirestore.instance.collection('drivers').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phone_number': user.phoneNumber ?? "+911234567890",
        'registration_status': 'incomplete',
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save details: $e')));
    }
  }

  Future<void> updateDriverAge({
    required int age,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not authenticated");
      }

      // Update the age in Firestore
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid)
          .update({'age': age});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update age: $e')));
    }
  }
}
