import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to get the stream of rides assigned to a driver
final driverRidesProvider =
    StreamProvider.family<List<DocumentSnapshot>, String>((ref, driverId) {
      return FirebaseFirestore.instance
          .collection('driverRides')
          .where('driverUid', isEqualTo: driverId)
          .snapshots()
          .map((snapshot) => snapshot.docs);
    });

// Provider to get the details of a specific ride from the 'rides' collection
final rideDetailsProvider = FutureProvider.family<DocumentSnapshot, String>((
  ref,
  rideId,
) {
  return FirebaseFirestore.instance.collection('rides').doc(rideId).get();
});
