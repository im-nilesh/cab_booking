import 'package:cab_booking_user/Widgets/title/location_suggestion_title_widget.dart';
import 'package:cab_booking_user/components/users/search%20components/top_search_container.dart';
import 'package:cab_booking_user/components/users/search%20components/no_rides_found.dart';
import 'package:cab_booking_user/providers/destination_provider.dart';
import 'package:cab_booking_user/providers/origin_query_provider.dart';
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
                  // Origin suggestions
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

                  if (!showOriginSuggestions && !showDestinationSuggestions)
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
