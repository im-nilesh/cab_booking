import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider for the origin search query
final originQueryProvider = StateProvider<String>((ref) => '');

// StreamProvider for fetching matching cityOne and their areas
final originSuggestionsProvider = StreamProvider<List<Map<String, dynamic>>>((
  ref,
) {
  final query = ref.watch(originQueryProvider).trim().toLowerCase();

  // Firestore stream for locations collection
  final stream = FirebaseFirestore.instance.collection('locations').snapshots();

  return stream.map((snapshot) {
    final matches =
        snapshot.docs
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final cityOne = (data['cityOne'] ?? '').toString();
              final areas =
                  (data['cityOneAreas'] as List<dynamic>?)
                      ?.map((e) => e.toString())
                      .toList() ??
                  [];
              return {'cityOne': cityOne, 'areas': areas};
            })
            .where(
              (item) =>
                  (item['cityOne'] as String).toLowerCase().contains(query),
            )
            .toList();

    return matches;
  });
});
