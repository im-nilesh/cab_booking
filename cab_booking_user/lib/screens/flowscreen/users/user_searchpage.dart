// lib/screens/flowscreen/users/user_searchpage.dart

import 'package:cab_booking_user/Widgets/car/car_options.dart';
import 'package:cab_booking_user/Widgets/title/location_suggestion_title_widget.dart';
import 'package:cab_booking_user/components/users/search%20components/no_rides_found.dart';
import 'package:cab_booking_user/components/users/search%20components/top_search_container.dart';
import 'package:cab_booking_user/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _originFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();

  String? selectedOriginCity;
  String? selectedDestinationCity;
  int? selectedCarIndex;

  @override
  void initState() {
    super.initState();
    _originFocus.addListener(() => setState(() {}));
    _destinationFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _originFocus.dispose();
    _destinationFocus.dispose();
    super.dispose();
  }

  List<String> normalizeCities(String c1, String c2) {
    final cities = [c1.trim(), c2.trim()]
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return cities;
  }

  Widget _buildSuggestions({
    required AsyncValue<List<Map<String, dynamic>>> suggestionsAsync,
    required void Function(String city, String area) onSelect,
  }) {
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
      error: (e, _) {
        debugPrint('Suggestions error: $e');
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Error loading suggestions'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final showOriginSuggestions =
        _originFocus.hasFocus && _originController.text.isNotEmpty;
    final showDestinationSuggestions =
        _destinationFocus.hasFocus && _destinationController.text.isNotEmpty;

    final originSuggestionsAsync = ref.watch(
      locationSearchProvider(_originController.text),
    );
    final destinationSuggestionsAsync = ref.watch(
      locationSearchProvider(_destinationController.text),
    );

    final showCarOptions =
        selectedOriginCity != null &&
        selectedDestinationCity != null &&
        !showOriginSuggestions &&
        !showDestinationSuggestions;

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

    return Scaffold(
      body: Column(
        children: [
          TopSearchContainer(
            originController: _originController,
            destinationController: _destinationController,
            originFocus: _originFocus,
            destinationFocus: _destinationFocus,
            onOriginChanged: (value) {
              setState(() {
                selectedOriginCity = null;
                selectedDestinationCity = null;
                selectedCarIndex = null;
              });
            },
            onDestinationChanged: (value) {
              setState(() {}); // triggers rebuild and provider fetch
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showOriginSuggestions)
                    _buildSuggestions(
                      suggestionsAsync: originSuggestionsAsync,
                      onSelect: (city, area) {
                        _originController.text = "$area, $city";
                        selectedOriginCity = city.trim();
                        _originFocus.unfocus();
                        setState(() {});
                      },
                    ),
                  if (showDestinationSuggestions)
                    _buildSuggestions(
                      suggestionsAsync: destinationSuggestionsAsync,
                      onSelect: (city, area) {
                        _destinationController.text = "$area, $city";
                        selectedDestinationCity = city.trim();
                        _destinationFocus.unfocus();
                        setState(() {});
                      },
                    ),
                  if (showCarOptions)
                    Consumer(
                      builder: (context, ref, _) {
                        if (selectedOriginCity == null ||
                            selectedDestinationCity == null) {
                          return const SizedBox.shrink();
                        }

                        // Create a string key from the normalized cities
                        final pairKey = normalizeCities(
                          selectedOriginCity!,
                          selectedDestinationCity!,
                        ).join('-');

                        final priceAsync = ref.watch(
                          routePriceProvider(
                            pairKey,
                          ), // Pass string key instead of List
                        );

                        return priceAsync.when(
                          data: (prices) {
                            if (prices.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No pricing available for this route.',
                                ),
                              );
                            }

                            return Column(
                              children: [
                                for (int i = 0; i < carOptions.length; i++)
                                  CarOptionCard(
                                    carName: carOptions[i]['name']!,
                                    price:
                                        int.tryParse(
                                          prices[carOptions[i]['key']]
                                                  ?.toString() ??
                                              '0',
                                        ) ??
                                        0,
                                    imagePath: carOptions[i]['image']!,
                                    isSelected: selectedCarIndex == i,
                                    onTap: () {
                                      setState(() {
                                        selectedCarIndex = i;
                                      });
                                    },
                                  ),
                              ],
                            );
                          },
                          loading:
                              () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          error:
                              (e, _) => const Center(
                                child: Text('Error loading prices.'),
                              ),
                        );
                      },
                    ),

                  if (!showOriginSuggestions &&
                      !showDestinationSuggestions &&
                      !showCarOptions)
                    const NoRidesFound(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
