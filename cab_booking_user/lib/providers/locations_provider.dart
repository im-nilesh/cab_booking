import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationSearchProvider = FutureProvider.family<List<String>, String>((
  ref,
  query,
) async {
  if (query.isEmpty) return [];

  final snapshot =
      await FirebaseFirestore.instance
          .collection('locations')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .limit(10)
          .get();

  return snapshot.docs.map((doc) => doc['name'] as String).toList();
});
