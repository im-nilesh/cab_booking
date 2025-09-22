import 'package:cab_booking_user/Widgets/car/car_options.dart';
import 'package:cab_booking_user/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarOptionsList extends ConsumerWidget {
  final String originCity;
  final String destinationCity;
  final int? selectedCarIndex;
  final void Function(int) onCarSelected;
  final List<String> Function(String, String) normalizeCities;

  const CarOptionsList({
    super.key,
    required this.originCity,
    required this.destinationCity,
    required this.selectedCarIndex,
    required this.onCarSelected,
    required this.normalizeCities,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pairKey = normalizeCities(originCity, destinationCity).join('-');

    final carOptions = [
      {'name': 'sedan', 'key': 'sedan', 'image': 'assets/images/sedan.png'},
      {
        'name': 'Hatchback',
        'key': 'hatchback',
        'image': 'assets/images/hatchback.png',
      },
      {'name': 'SUV', 'key': 'suvErtiga', 'image': 'assets/images/suv.png'},
      {'name': 'Luxury', 'key': 'xylo', 'image': 'assets/images/luxury.png'},
    ];

    final priceAsync = ref.watch(routePriceProvider(pairKey));

    return priceAsync.when(
      data: (prices) {
        if (prices.isEmpty) {
          return const Center(
            child: Text('No pricing available for this route.'),
          );
        }

        return Column(
          children: [
            for (int i = 0; i < carOptions.length; i++)
              CarOptionCard(
                carName: carOptions[i]['name']!,
                price:
                    int.tryParse(
                      prices[carOptions[i]['key']]?.toString() ?? '0',
                    ) ??
                    0,
                imagePath: carOptions[i]['image']!,
                isSelected: selectedCarIndex == i,
                onTap: () => onCarSelected(i),
              ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => const Center(child: Text('Error loading prices.')),
    );
  }
}
