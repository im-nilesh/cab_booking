import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider for the destination search query
final destinationQueryProvider = StateProvider<String>((ref) => '');

// StreamProvider for fetching matching cityTwo and their areas
final destinationSuggestionsProvider =
    StreamProvider<List<Map<String, dynamic>>>((ref) {
      final query = ref.watch(destinationQueryProvider).trim().toLowerCase();

      final stream =
          FirebaseFirestore.instance.collection('locations').snapshots();

      return stream.map((snapshot) {
        final matches =
            snapshot.docs
                .map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final cityTwo = (data['cityTwo'] ?? '').toString();
                  final areas =
                      (data['cityTwoAreas'] as List<dynamic>?)
                          ?.map((e) => e.toString())
                          .toList() ??
                      [];
                  return {'cityTwo': cityTwo, 'areas': areas};
                })
                .where(
                  (item) =>
                      (item['cityTwo'] as String).toLowerCase().contains(query),
                )
                .toList();

        return matches;
      });
    });
