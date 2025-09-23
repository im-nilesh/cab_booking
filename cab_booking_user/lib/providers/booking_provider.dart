import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingProvider = Provider<BookingService>((ref) => BookingService());

class BookingService {
  Future<void> createRide({
    required String origin,
    required String destination,
    required DateTime dateTime,
    required Map<String, dynamic> carDetails,
    required String status,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('rides').add({
      'userId': user.uid,
      'origin': origin,
      'destination': destination,
      'dateTime': dateTime,
      'carDetails': carDetails,
      'prices': carDetails['prices'] ?? {},
      'status': status,
    });
  }
}
