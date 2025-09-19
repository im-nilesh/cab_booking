import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider for the origin search query
final originQueryProvider = StateProvider<String>((ref) => '');

// StreamProvider for fetching unique matching cityOne and their areas
final originSuggestionsProvider = StreamProvider<List<Map<String, dynamic>>>((
  ref,
) {
  final query = ref.watch(originQueryProvider).trim().toLowerCase();

  // If the query is empty, return an empty list immediately.
  if (query.isEmpty) {
    return Stream.value([]);
  }

  final stream = FirebaseFirestore.instance.collection('locations').snapshots();

  return stream.map((snapshot) {
    final cityAreaMap = <String, Set<String>>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      // Trim the city name to remove leading/trailing whitespace
      final cityOne = (data['cityOne'] ?? '').toString().trim();
      final areas =
          (data['cityOneAreas'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];

      // Check if the city name contains the search query
      if (cityOne.toLowerCase().contains(query)) {
        // If the city is not yet in our map, add it.
        cityAreaMap.putIfAbsent(cityOne, () => <String>{});
        // Add all areas from this document to the city's set of areas.
        cityAreaMap[cityOne]!.addAll(areas);
      }
    }

    // Convert the map to the List format required by the UI.
    final matches =
        cityAreaMap.entries.map((entry) {
          return {'cityOne': entry.key, 'areas': entry.value.toList()};
        }).toList();

    return matches;
  });
});
