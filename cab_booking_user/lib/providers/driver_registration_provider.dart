import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final driverRegistrationProvider = ChangeNotifierProvider(
  (ref) => DriverRegistrationProvider(),
);

class DriverRegistrationProvider with ChangeNotifier {
  bool _isUploading = false;
  String? _imageUrl;
  bool _isProfileCreated = false;

  bool get isUploading => _isUploading;
  String? get imageUrl => _imageUrl;
  bool get isProfileCreated => _isProfileCreated;

  void setUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

  void setProfileCreated(bool value) {
    _isProfileCreated = value;
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
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not authenticated")),
          );
        }
        return;
      }

      await FirebaseFirestore.instance.collection('drivers').doc(user.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'phone_number': user.phoneNumber ?? "+911234567890",
        'registration_status': 'incomplete', // must match AuthGate
        'isProfileCreated': true,
      });

      setProfileCreated(true);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to save details: $e')));
      }
    }
  }

  Future<void> updateDriverAge({
    required int age,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not authenticated")),
          );
        }
        return;
      }
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid)
          .update({'age': age});
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update age: $e')));
      }
    }
  }

  Future<void> uploadDriverPhoto({
    required String photoPath,
    required BuildContext context,
  }) async {
    setUploading(true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final filePath = 'driver_photos/${user.uid}.jpg';
      final storageRef = FirebaseStorage.instance.ref().child(filePath);
      await storageRef.putFile(File(photoPath));

      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid)
          .update({'photo_path': filePath});
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to upload photo: $e')));
      }
    } finally {
      setUploading(false);
    }
  }

  Future<void> fetchProfileImage(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final doc =
          await FirebaseFirestore.instance
              .collection('drivers')
              .doc(user.uid)
              .get();

      final photoPath = doc.data()?['photo_path'];
      if (photoPath != null) {
        final url =
            await FirebaseStorage.instance.ref(photoPath).getDownloadURL();
        _imageUrl = url;
        notifyListeners();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile image: $e')),
        );
      }
    }
  }

  Future<void> saveVehicleNumber({
    required String vehicleNumber,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid)
          .update({'vehicle_number': vehicleNumber});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vehicle number saved successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save vehicle number: $e')),
        );
      }
    }
  }

  Future<void> uploadDriverDocuments({
    required File? drivingLicenseFile,
    required File? vehicleNumberPlateFile,
    required File? rcFile,
    required BuildContext context,
  }) async {
    setUploading(true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not authenticated");

      final storage = FirebaseStorage.instance;
      final docRef = FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid);

      Map<String, String> docPaths = {};
      if (drivingLicenseFile != null) {
        final dlPath = 'driver_docs/${user.uid}/driving_license.jpg';
        await storage.ref(dlPath).putFile(drivingLicenseFile);
        docPaths['driving_license_path'] = dlPath;
      }
      if (vehicleNumberPlateFile != null) {
        final npPath = 'driver_docs/${user.uid}/number_plate.jpg';
        await storage.ref(npPath).putFile(vehicleNumberPlateFile);
        docPaths['number_plate_path'] = npPath;
      }
      if (rcFile != null) {
        final rcPath = 'driver_docs/${user.uid}/rc.jpg';
        await storage.ref(rcPath).putFile(rcFile);
        docPaths['rc_path'] = rcPath;
      }
      if (docPaths.isNotEmpty) await docRef.update(docPaths);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Documents uploaded successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload documents: $e')),
        );
      }
    } finally {
      setUploading(false);
    }
  }

  Future<void> uploadAdditionalDriverDocuments({
    required File? insuranceCopyFile,
    required File? pollutionCertificateFile,
    required BuildContext context,
  }) async {
    setUploading(true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not authenticated");

      final storage = FirebaseStorage.instance;
      final docRef = FirebaseFirestore.instance
          .collection('drivers')
          .doc(user.uid);

      Map<String, String> docPaths = {};
      if (insuranceCopyFile != null) {
        final insurancePath = 'driver_docs/${user.uid}/insurance_copy.jpg';
        await storage.ref(insurancePath).putFile(insuranceCopyFile);
        docPaths['insurance_copy_path'] = insurancePath;
      }
      if (pollutionCertificateFile != null) {
        final pollutionPath =
            'driver_docs/${user.uid}/pollution_certificate.jpg';
        await storage.ref(pollutionPath).putFile(pollutionCertificateFile);
        docPaths['pollution_certificate_path'] = pollutionPath;
      }
      if (docPaths.isNotEmpty) await docRef.update(docPaths);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Additional documents uploaded successfully!'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload additional documents: $e')),
        );
      }
    } finally {
      setUploading(false);
    }
  }
}
