import 'package:cab_booking_user/Widgets/title/location_suggestion_title_widget.dart';
import 'package:cab_booking_user/components/users/search%20screen%20components/no_rides_found.dart';
import 'package:cab_booking_user/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationSuggestionsList extends ConsumerWidget {
  final String query;
  final void Function(String city, String area) onSelect;

  const LocationSuggestionsList({
    super.key,
    required this.query,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestionsAsync = ref.watch(locationSearchProvider(query));

    return suggestionsAsync.when(
      data: (suggestions) {
        if (suggestions.isEmpty) return const NoRidesFound();

        return Column(
          children:
              suggestions.expand((item) {
                final city = item['city'] as String? ?? '';
                final areas = (item['areas'] as List).cast<String>();
                return areas.map(
                  (area) => LocationSuggestionTile(
                    city: city,
                    address: area,
                    onTap: () => onSelect(city, area),
                  ),
                );
              }).toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (e, _) => const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Error loading suggestions'),
          ),
    );
  }
}
