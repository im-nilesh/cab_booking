import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Provider for the destination search query
final destinationQueryProvider = StateProvider<String>((ref) => '');

// StreamProvider for fetching unique matching cityTwo and their areas
final destinationSuggestionsProvider =
    StreamProvider<List<Map<String, dynamic>>>((ref) {
      final query = ref.watch(destinationQueryProvider).trim().toLowerCase();

      // If the query is empty, return an empty list immediately.
      if (query.isEmpty) {
        return Stream.value([]);
      }

      final stream =
          FirebaseFirestore.instance.collection('locations').snapshots();

      return stream.map((snapshot) {
        final cityAreaMap = <String, Set<String>>{};

        for (final doc in snapshot.docs) {
          final data = doc.data();
          final cityTwo = (data['cityTwo'] ?? '').toString();
          final areas =
              (data['cityTwoAreas'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [];

          // Check if the city name contains the search query
          if (cityTwo.toLowerCase().contains(query)) {
            // If the city is not yet in our map, add it.
            cityAreaMap.putIfAbsent(cityTwo, () => <String>{});
            // Add all areas from this document to the city's set of areas.
            // Using a Set automatically handles duplicate areas.
            cityAreaMap[cityTwo]!.addAll(areas);
          }
        }

        // Convert the map to the List format required by the UI.
        final matches =
            cityAreaMap.entries.map((entry) {
              return {'cityTwo': entry.key, 'areas': entry.value.toList()};
            }).toList();

        return matches;
      });
    });
