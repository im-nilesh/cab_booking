// lib/widgets/search_body_content.dart

import 'package:cab_booking_user/Widgets/car/car_option_list.dart';
import 'package:cab_booking_user/Widgets/title/location_suggestion_list.dart';
import 'package:cab_booking_user/components/users/search%20components/no_rides_found.dart';
import 'package:flutter/material.dart';

class SearchBodyContent extends StatelessWidget {
  final bool showOriginSuggestions;
  final bool showDestinationSuggestions;
  final bool showCarOptions;
  final TextEditingController originController;
  final TextEditingController destinationController;
  final String? selectedOriginCity;
  final String? selectedDestinationCity;
  final int? selectedCarIndex;
  final Function(String city, String area) onOriginSelect;
  final Function(String city, String area) onDestinationSelect;
  final Function(Map<String, dynamic> carDetails) onCarSelected;
  final List<String> Function(String, String) normalizeCities;

  const SearchBodyContent({
    super.key,
    required this.showOriginSuggestions,
    required this.showDestinationSuggestions,
    required this.showCarOptions,
    required this.originController,
    required this.destinationController,
    required this.selectedOriginCity,
    required this.selectedDestinationCity,
    required this.selectedCarIndex,
    required this.onOriginSelect,
    required this.onDestinationSelect,
    required this.onCarSelected,
    required this.normalizeCities,
  });

  @override
  Widget build(BuildContext context) {
    // The main content area is wrapped in an Expanded widget to fill available space.
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showOriginSuggestions)
              LocationSuggestionsList(
                query: originController.text,
                onSelect: onOriginSelect,
              ),
            if (showDestinationSuggestions)
              LocationSuggestionsList(
                query: destinationController.text,
                onSelect: onDestinationSelect,
              ),
            if (showCarOptions)
              CarOptionsList(
                originCity: selectedOriginCity!,
                destinationCity: selectedDestinationCity!,
                selectedCarIndex: selectedCarIndex,
                onCarSelected: onCarSelected,
                normalizeCities: normalizeCities,
              ),
            // Fallback view when no other content is shown
            if (!showOriginSuggestions &&
                !showDestinationSuggestions &&
                !showCarOptions)
              const Center(child: NoRidesFound()),
          ],
        ),
      ),
    );
  }
}
