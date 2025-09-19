import 'package:cab_booking_user/providers/locations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cab_booking_user/components/users/search%20components/no_rides_found.dart';
import 'package:cab_booking_user/components/users/search%20components/top_search_container.dart';
import 'package:cab_booking_user/utils/constants.dart';

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
    final query = _originController.text;
    final locationAsync = ref.watch(locationSearchProvider(query));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          TopSearchContainer(
            originController: _originController,
            destinationController: _destinationController,
            originFocus: _originFocus,
            destinationFocus: _destinationFocus,
          ),
          // Show suggestions only if origin field is focused and has text
          if (_originFocus.hasFocus && query.isNotEmpty)
            locationAsync.when(
              data: (locations) {
                if (locations.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No locations found'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return ListTile(
                      title: Text(location),
                      onTap: () {
                        _originController.text = location;
                        _originFocus.unfocus();
                      },
                    );
                  },
                );
              },
              loading:
                  () => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
              error:
                  (e, _) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Error fetching locations: $e'),
                  ),
            ),
          const Spacer(),
          const NoRidesFound(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
