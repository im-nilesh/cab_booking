import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookedRidesProvider = StreamProvider<List<QueryDocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance
      .collection('rides')
      .where('status', isEqualTo: 'success')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});

final failedRidesProvider = StreamProvider<List<QueryDocumentSnapshot>>((ref) {
  return FirebaseFirestore.instance
      .collection('rides')
      .where('status', isEqualTo: 'failure')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});
