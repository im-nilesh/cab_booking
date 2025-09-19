import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceProvider = StreamProvider.autoDispose
    .family<Map<String, dynamic>, String>((ref, cityPair) {
      // cityPair should be in the format "cityOne-cityTwo"
      final cities = cityPair.split('-');
      if (cities.length != 2) {
        return Stream.value({});
      }

      return FirebaseFirestore.instance
          .collection('locations')
          .where('cityOne', isEqualTo: cities[0])
          .where('cityTwo', isEqualTo: cities[1])
          .snapshots()
          .map((snapshot) {
            if (snapshot.docs.isNotEmpty) {
              final data = snapshot.docs.first.data();
              return data['prices'] as Map<String, dynamic>? ?? {};
            }
            return {};
          });
    });
