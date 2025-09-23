import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allRidesProvider = StreamProvider<List<QueryDocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance
      .collection('rides')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});

final bookedRidesProvider = StreamProvider<List<QueryDocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance
      .collection('rides')
      .where('payment_status', isEqualTo: 'success')
      .where('ride_status', isEqualTo: 'created')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});

final failedRidesProvider = StreamProvider<List<QueryDocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance
      .collection('rides')
      .where('payment_status', isEqualTo: 'failure')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});
