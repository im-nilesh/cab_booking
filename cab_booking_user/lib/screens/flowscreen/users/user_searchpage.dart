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
            child: Builder(
              builder: (_) {
                // Show origin suggestions
                if (showOriginSuggestions) {
                  return originSuggestionsAsync.when(
                    data: (suggestions) {
                      if (suggestions.isEmpty) {
                        return const NoRidesFound();
                      }
                      return ListView.builder(
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final item = suggestions[index];
                          final city = item['cityOne'];
                          final areas = item['areas'] as List<String>;
                          return ListTile(
                            title: Text(city),
                            subtitle:
                                areas.isNotEmpty
                                    ? Text(areas.join(', '))
                                    : null,
                            onTap: () {
                              _originController.text = city;
                              _originFocus.unfocus();
                            },
                          );
                        },
                      );
                    },
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error:
                        (e, _) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Error loading origin cities'),
                        ),
                  );
                }

                // Show destination suggestions
                if (showDestinationSuggestions) {
                  return destinationSuggestionsAsync.when(
                    data: (suggestions) {
                      if (suggestions.isEmpty) {
                        return const NoRidesFound();
                      }
                      return ListView.builder(
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final item = suggestions[index];
                          final city = item['cityTwo'];
                          final areas = item['areas'] as List<String>;
                          return ListTile(
                            title: Text(city),
                            subtitle:
                                areas.isNotEmpty
                                    ? Text(areas.join(', '))
                                    : null,
                            onTap: () {
                              _destinationController.text = city;
                              _destinationFocus.unfocus();
                            },
                          );
                        },
                      );
                    },
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    error:
                        (e, _) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Error loading destination cities'),
                        ),
                  );
                }

                return const NoRidesFound();
              },
            ),
          ),
        ],
      ),
    );
  }
}
