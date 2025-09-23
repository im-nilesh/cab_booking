// lib/providers/location_provider.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationSearchProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>((
      ref,
      query,
    ) async {
      if (query.trim().isEmpty) return [];

      final normalizedQuery = query.trim().toLowerCase();
      final snapshot =
          await FirebaseFirestore.instance.collection('locations').get();

      final results = <Map<String, dynamic>>[];

      for (final doc in snapshot.docs) {
        final data = doc.data();

        debugPrint('Location doc: ${doc.id} -> $data');

        final cityOne = (data['cityOne'] ?? '').toString().trim();
        final cityTwo = (data['cityTwo'] ?? '').toString().trim();
        final cityOneAreas =
            (data['cityOneAreas'] as List<dynamic>? ?? [])
                .map((e) => e.toString())
                .toList();
        final cityTwoAreas =
            (data['cityTwoAreas'] as List<dynamic>? ?? [])
                .map((e) => e.toString())
                .toList();
        final prices = Map<String, dynamic>.from(data['prices'] ?? {});
        final advancePrice = data['advancePrice'] ?? 0;

        // Match city names
        if (cityOne.toLowerCase().contains(normalizedQuery)) {
          results.add({
            'city': cityOne,
            'areas': cityOneAreas,
            'prices': prices,
            'advancePrice': advancePrice,
          });
        }
        if (cityTwo.toLowerCase().contains(normalizedQuery)) {
          results.add({
            'city': cityTwo,
            'areas': cityTwoAreas,
            'prices': prices,
            'advancePrice': advancePrice,
          });
        }

        // Match inside areas
        final matchedAreasOne =
            cityOneAreas
                .where((a) => a.toLowerCase().contains(normalizedQuery))
                .toList();
        if (matchedAreasOne.isNotEmpty) {
          results.add({
            'city': cityOne,
            'areas': matchedAreasOne,
            'prices': prices,
            'advancePrice': advancePrice,
          });
        }
        final matchedAreasTwo =
            cityTwoAreas
                .where((a) => a.toLowerCase().contains(normalizedQuery))
                .toList();
        if (matchedAreasTwo.isNotEmpty) {
          results.add({
            'city': cityTwo,
            'areas': matchedAreasTwo,
            'prices': prices,
            'advancePrice': advancePrice,
          });
        }
      }

      return results;
    });

final routePriceProvider = FutureProvider.family<Map<String, dynamic>, String>((
  ref,
  pairKey,
) async {
  debugPrint('routePriceProvider called with pairKey: $pairKey');

  final cities = pairKey.split('-');
  if (cities.length != 2) {
    debugPrint('Invalid cities in pairKey: $pairKey');
    return {};
  }

  final snapshot =
      await FirebaseFirestore.instance.collection('locations').get();
  debugPrint('Fetched ${snapshot.docs.length} location docs from Firestore');

  final normalizedCities = List<String>.from(cities)
    ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
  debugPrint('Normalized cities: $normalizedCities');

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final cityOne = (data['cityOne'] ?? '').toString().trim();
    final cityTwo = (data['cityTwo'] ?? '').toString().trim();

    final citiesInDoc = [cityOne, cityTwo]
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    debugPrint('Checking doc ${doc.id} with cities: $citiesInDoc');

    if (normalizedCities[0] == citiesInDoc[0] &&
        normalizedCities[1] == citiesInDoc[1]) {
      final prices = Map<String, dynamic>.from(data['prices'] ?? {});
      debugPrint('Matched doc ${doc.id}, prices: $prices');
      return prices; // ✅ only return prices
    }
  }

  debugPrint('No matching doc found for cities: $normalizedCities');
  return {};
});
