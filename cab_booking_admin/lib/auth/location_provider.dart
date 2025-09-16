// lib/providers/location_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the search query state
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider that listens to the Firestore 'locations' collection
final locationsStreamProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('locations').snapshots();
});

// A provider that filters the locations based on the search query
final filteredLocationsProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final locationsSnapshot = ref.watch(locationsStreamProvider);

  return locationsSnapshot.when(
    data: (snapshot) {
      final allLocations =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final Map<String, dynamic> prices = data['prices'] ?? {};
            return {
              'id': doc.id,
              'cityOne': data['cityOne'] ?? '',
              'cityTwo': data['cityTwo'] ?? '',
              'cityOneAreas':
                  (data['cityOneAreas'] as List<dynamic>?)?.join(', ') ?? '',
              'cityTwoAreas':
                  (data['cityTwoAreas'] as List<dynamic>?)?.join(', ') ?? '',
              'advancePrice': data['advancePrice'] ?? '',
              'pricesCombined':
                  'S: ${prices['sedan'] ?? ''}, H: ${prices['hatchback'] ?? ''}, E: ${prices['suvErtiga'] ?? ''}, X: ${prices['xylo'] ?? ''}',
              'originalData':
                  data, // Pass the original data for the edit dialog
            };
          }).toList();

      if (query.isEmpty) {
        return allLocations;
      } else {
        return allLocations.where((loc) {
          return loc['cityOne']!.toLowerCase().contains(query) ||
              loc['cityTwo']!.toLowerCase().contains(query) ||
              loc['cityOneAreas']!.toLowerCase().contains(query) ||
              loc['cityTwoAreas']!.toLowerCase().contains(query) ||
              loc['pricesCombined']!.toLowerCase().contains(query) ||
              loc['advancePrice']!.toLowerCase().contains(query);
        }).toList();
      }
    },
    loading: () => [],
    error: (e, stack) => [],
  );
});
