// lib/pages/search_page.dart (or wherever your original file is)

import 'package:cab_booking_user/components/users/search%20components/booking_details.dart';
import 'package:cab_booking_user/components/users/search%20components/search_body_content.dart';
import 'package:cab_booking_user/components/users/search%20components/top_search_container.dart';

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
  DateTime selectedDateTime = DateTime.now();

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

  void _showBookingDetailsDialog(Map<String, dynamic> carDetails) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BookingDetailsDialog(
          origin: _originController.text,
          destination: _destinationController.text,
          dateTime: selectedDateTime,
          carDetails: carDetails,
        );
      },
    );
  }

  // Extracted logic into a dedicated method for clarity
  void _onOriginSelect(String city, String area) {
    setState(() {
      _originController.text = "$area, $city";
      selectedOriginCity = city.trim();
      _originFocus.unfocus();
    });
  }

  // Extracted logic into a dedicated method for clarity
  void _onDestinationSelect(String city, String area) {
    setState(() {
      _destinationController.text = "$area, $city";
      selectedDestinationCity = city.trim();
      _destinationFocus.unfocus();
    });
  }

  // Extracted logic into a dedicated method for clarity
  void _onCarSelected(Map<String, dynamic> carDetails) {
    setState(() {
      selectedCarIndex = carDetails['index'];
    });
    _showBookingDetailsDialog(carDetails);
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
              setState(() {});
            },
            onDateTimeChanged: (dateTime) {
              setState(() {
                selectedDateTime = dateTime;
              });
            },
          ),
          // Use the new custom widget here
          SearchBodyContent(
            showOriginSuggestions: showOriginSuggestions,
            showDestinationSuggestions: showDestinationSuggestions,
            showCarOptions: showCarOptions,
            originController: _originController,
            destinationController: _destinationController,
            selectedOriginCity: selectedOriginCity,
            selectedDestinationCity: selectedDestinationCity,
            selectedCarIndex: selectedCarIndex,
            onOriginSelect: _onOriginSelect,
            onDestinationSelect: _onDestinationSelect,
            onCarSelected: _onCarSelected,
            normalizeCities: normalizeCities,
          ),
        ],
      ),
    );
  }
}
