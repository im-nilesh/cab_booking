import 'package:cab_booking_user/Widgets/car/car_option_list.dart';
import 'package:cab_booking_user/Widgets/title/location_suggestion_list.dart';
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

  @override
  Widget build(BuildContext context) {
    final showOriginSuggestions =
        _originFocus.hasFocus && _originController.text.isNotEmpty;
    final showDestinationSuggestions =
        _destinationFocus.hasFocus && _destinationController.text.isNotEmpty;

    final showCarOptions =
        selectedOriginCity != null &&
        selectedDestinationCity != null &&
        !showOriginSuggestions &&
        !showDestinationSuggestions;

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showOriginSuggestions)
                    LocationSuggestionsList(
                      query: _originController.text,
                      onSelect: (city, area) {
                        _originController.text = "$area, $city";
                        selectedOriginCity = city.trim();
                        _originFocus.unfocus();
                        setState(() {});
                      },
                    ),
                  if (showDestinationSuggestions)
                    LocationSuggestionsList(
                      query: _destinationController.text,
                      onSelect: (city, area) {
                        _destinationController.text = "$area, $city";
                        selectedDestinationCity = city.trim();
                        _destinationFocus.unfocus();
                        setState(() {});
                      },
                    ),
                  if (showCarOptions)
                    CarOptionsList(
                      originCity: selectedOriginCity!,
                      destinationCity: selectedDestinationCity!,
                      selectedCarIndex: selectedCarIndex,
                      onCarSelected:
                          (index) => setState(() => selectedCarIndex = index),
                      normalizeCities: normalizeCities,
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
