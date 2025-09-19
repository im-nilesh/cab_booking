import 'package:cab_booking_user/Widgets/car/car_options.dart';
import 'package:cab_booking_user/Widgets/title/location_suggestion_title_widget.dart';
import 'package:cab_booking_user/components/users/search%20components/no_rides_found.dart';
import 'package:cab_booking_user/components/users/search%20components/top_search_container.dart';
import 'package:cab_booking_user/providers/destination_provider.dart';
import 'package:cab_booking_user/providers/origin_query_provider.dart';
import 'package:cab_booking_user/providers/price_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final originSuggestionsAsync = ref.watch(originSuggestionsProvider);
    final destinationSuggestionsAsync = ref.watch(
      destinationSuggestionsProvider,
    );

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
              ref.read(originQueryProvider.notifier).state = value;
              setState(() {
                selectedOriginCity = null;
                selectedDestinationCity = null;
                selectedCarIndex = null;
              });
            },
            onDestinationChanged: (value) {
              ref.read(destinationQueryProvider.notifier).state = value;
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
                    originSuggestionsAsync.when(
                      data: (suggestions) {
                        if (suggestions.isEmpty) return const NoRidesFound();
                        return Column(
                          children:
                              suggestions.expand((item) {
                                final city = item['cityOne'] as String? ?? '';
                                final areas =
                                    (item['areas'] as List).cast<String>();
                                return areas.map(
                                  (area) => LocationSuggestionTile(
                                    city: city,
                                    address: area,
                                    onTap: () {
                                      _originController.text = "$area, $city";
                                      selectedOriginCity = city;
                                      _originFocus.unfocus();
                                      setState(() {});
                                    },
                                  ),
                                );
                              }).toList(),
                        );
                      },
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (e, _) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Error loading origin cities'),
                          ),
                    ),
                  if (showDestinationSuggestions)
                    destinationSuggestionsAsync.when(
                      data: (suggestions) {
                        if (suggestions.isEmpty) return const NoRidesFound();
                        return Column(
                          children:
                              suggestions.expand((item) {
                                final city = item['cityTwo'] as String? ?? '';
                                final areas =
                                    (item['areas'] as List).cast<String>();
                                return areas.map(
                                  (area) => LocationSuggestionTile(
                                    city: city,
                                    address: area,
                                    onTap: () {
                                      _destinationController.text =
                                          "$area, $city";
                                      selectedDestinationCity = city;
                                      _destinationFocus.unfocus();
                                      setState(() {});
                                    },
                                  ),
                                );
                              }).toList(),
                        );
                      },
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error:
                          (e, _) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Error loading destination cities'),
                          ),
                    ),
                  if (showCarOptions)
                    Consumer(
                      builder: (context, ref, child) {
                        final priceValue = ref.watch(
                          priceProvider(
                            '$selectedOriginCity-$selectedDestinationCity',
                          ),
                        );

                        return priceValue.when(
                          data: (prices) {
                            if (prices.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    'No pricing available for this route.',
                                  ),
                                ),
                              );
                            }

                            return Column(
                              children: [
                                CarOptionCard(
                                  carName: 'Sedan',
                                  price:
                                      int.tryParse(
                                        prices['sedan']?.toString() ?? '0',
                                      ) ??
                                      0,
                                  imagePath: 'assets/images/sedan.png',
                                  isSelected: selectedCarIndex == 0,
                                  onTap: () {
                                    setState(() {
                                      selectedCarIndex = 0;
                                    });
                                  },
                                ),
                                CarOptionCard(
                                  carName: 'Hatchback',
                                  price:
                                      int.tryParse(
                                        prices['hatchback']?.toString() ?? '0',
                                      ) ??
                                      0,
                                  imagePath: 'assets/images/hatchback.png',
                                  isSelected: selectedCarIndex == 1,
                                  onTap: () {
                                    setState(() {
                                      selectedCarIndex = 1;
                                    });
                                  },
                                ),
                                CarOptionCard(
                                  carName: 'SUV',
                                  price:
                                      int.tryParse(
                                        prices['suvErtiga']?.toString() ?? '0',
                                      ) ??
                                      0,
                                  imagePath: 'assets/images/suv.png',
                                  isSelected: selectedCarIndex == 2,
                                  onTap: () {
                                    setState(() {
                                      selectedCarIndex = 2;
                                    });
                                  },
                                ),
                                CarOptionCard(
                                  carName: 'Luxury',
                                  price:
                                      int.tryParse(
                                        prices['xylo']?.toString() ?? '0',
                                      ) ??
                                      0,
                                  imagePath: 'assets/images/luxury.png',
                                  isSelected: selectedCarIndex == 3,
                                  onTap: () {
                                    setState(() {
                                      selectedCarIndex = 3;
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
                              (error, stack) => const Center(
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
