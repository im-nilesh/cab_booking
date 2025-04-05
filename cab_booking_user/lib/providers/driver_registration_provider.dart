import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

final driverRegistrationProvider = Provider(
  (ref) => DriverRegistrationProvider(),
);

class DriverRegistrationProvider with ChangeNotifier {
  bool _isUploading = false;

  bool get isUploading => _isUploading;

  void setUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

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

  Future<void> uploadDriverPhoto({
    required String photoPath,
    required BuildContext context,
  }) async {
    try {
      setUploading(true); // Set uploading state to true
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not authenticated");
      }

      // Define the file path in Firebase Storage
      final filePath = 'driver_photos/${user.uid}.jpg';

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child(filePath);
      final uploadTask = storageRef.putFile(File(photoPath));

      // Wait for the upload to complete
      await uploadTask;

      // Update Firestore with the file path
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid)
          .update({'photo_path': filePath})
      // Show success message
      ;
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to upload photo: $e')));
    } finally {
      setUploading(false); // Set uploading state to false
    }
  }
}
