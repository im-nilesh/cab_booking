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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showOriginSuggestions)
                    originSuggestionsAsync.when(
                      data: (suggestions) {
                        if (suggestions.isEmpty) return const NoRidesFound();
                        final tiles = <Widget>[];
                        for (final item in suggestions) {
                          final city = item['cityOne'] as String? ?? '';
                          final areas = (item['areas'] as List).cast<String>();
                          for (final area in areas) {
                            tiles.add(
                              LocationSuggestionTile(
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
                          }
                        }
                        return Column(children: tiles);
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

                  // Destination suggestions
                  if (showDestinationSuggestions)
                    destinationSuggestionsAsync.when(
                      data: (suggestions) {
                        if (suggestions.isEmpty) return const NoRidesFound();
                        final tiles = <Widget>[];
                        for (final item in suggestions) {
                          final city = item['cityTwo'] as String? ?? '';
                          final areas = (item['areas'] as List).cast<String>();
                          for (final area in areas) {
                            tiles.add(
                              LocationSuggestionTile(
                                city: city,
                                address: area,
                                onTap: () {
                                  _destinationController.text = "$area, $city";
                                  selectedDestinationCity = city;
                                  _destinationFocus.unfocus();
                                  setState(() {});
                                },
                              ),
                            );
                          }
                        }
                        return Column(children: tiles);
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

                            final carOptions = [
                              {
                                'name': 'Sedan',
                                'price': prices['sedan'],
                                'image': 'assets/images/sedan.png',
                              },
                              {
                                'name': 'Hatchback',
                                'price': prices['hatchback'],
                                'image': 'assets/images/hatchback.png',
                              },
                              {
                                'name': 'SUV',
                                'price': prices['suvErtiga'],
                                'image': 'assets/images/suv.png',
                              },
                              {
                                'name': 'Xylo',
                                'price': prices['xylo'],
                                'image': 'assets/images/luxury.png',
                              },
                            ];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Column(
                                children:
                                    carOptions.map((car) {
                                      final index = carOptions.indexOf(car);
                                      final price =
                                          int.tryParse(
                                            car['price'].toString(),
                                          ) ??
                                          0;

                                      return CarOptionCard(
                                        carName: car['name'] as String,
                                        price: price,
                                        imagePath: car['image'] as String,
                                        isSelected: selectedCarIndex == index,
                                        onTap: () {
                                          setState(() {
                                            selectedCarIndex = index;
                                          });
                                        },
                                      );
                                    }).toList(),
                              ),
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
