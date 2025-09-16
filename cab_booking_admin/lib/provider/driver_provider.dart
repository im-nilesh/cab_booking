import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage the search query state
final driversSearchQueryProvider = StateProvider<String>((ref) => '');

// Stream provider to listen to the Firestore 'drivers' collection
final driversStreamProvider = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('drivers').snapshots();
});

// Provider that filters the drivers based on the search query
final filteredDriversProvider = Provider<List<Map<String, dynamic>>>((ref) {
  final query = ref.watch(driversSearchQueryProvider).toLowerCase().trim();
  final driversAsyncValue = ref.watch(driversStreamProvider);

  return driversAsyncValue.when(
    data: (snapshot) {
      final allDrivers =
          snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {
              'id': doc.id,
              'firstName': data['firstName'] ?? '',
              'lastName': data['lastName'] ?? '',
              'phone': data['phone_number'] ?? '',
              'age': data['age']?.toString() ?? '',
              'vehicleNumber': data['vehicle_number'] ?? '',
              'status': data['status'] ?? 'active',
              'registration_status':
                  data['registration_status'] ??
                  'incomplete', // <-- Add this line
              'docs': {
                'rc_path': data['rc_path'],
                'pollution_certificate_path':
                    data['pollution_certificate_path'],
                'number_plate_path': data['number_plate_path'],
                'insurance_copy_path': data['insurance_copy_path'],
                'driving_license_path': data['driving_license_path'],
              },
            };
          }).toList();

      if (query.isEmpty) {
        return allDrivers;
      } else {
        return allDrivers.where((driver) {
          return driver['firstName']!.toLowerCase().contains(query) ||
              driver['lastName']!.toLowerCase().contains(query) ||
              driver['phone']!.contains(query) ||
              driver['vehicleNumber']!.toLowerCase().contains(query);
        }).toList();
      }
    },
    loading: () => [],
    error: (e, stack) => [],
  );
});

final updateDriverRegistrationStatusProvider =
    Provider<Future<void> Function(String, String)>((ref) {
      return (String driverId, String status) async {
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(driverId)
            .update({'registration_status': status});
      };
    });
