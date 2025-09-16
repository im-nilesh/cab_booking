import 'package:cab_booking_admin/provider/location_provider.dart';
import 'package:cab_booking_admin/widgets/add_location.dart';
import 'package:cab_booking_admin/widgets/edit_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/custom_table.dart';
import '../utils/constants.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({Key? key}) : super(key: key);

  void _showAddLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddLocationDialog();
      },
    );
  }

  void _showEditLocationDialog(
    BuildContext context,
    String documentId,
    Map<String, dynamic> locationData,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditLocationDialog(
          documentId: documentId,
          locationData: locationData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(filteredLocationsProvider);
    final locationsAsyncValue = ref.watch(locationsStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Locations and Pricing",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    ref.read(searchQueryProvider.notifier).state = query;
                  },
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greencolor,
                    foregroundColor: whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () => _showAddLocationDialog(context),
                  child: const Text(
                    "Add Location",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: locationsAsyncValue.when(
              data: (data) {
                if (locations.isEmpty &&
                    ref.read(searchQueryProvider).isEmpty) {
                  return const Center(child: Text('No locations found.'));
                } else if (locations.isEmpty &&
                    ref.read(searchQueryProvider).isNotEmpty) {
                  return const Center(
                    child: Text('No results for this search.'),
                  );
                }
                return CustomDataTable(
                  columns: const [
                    DataColumn(label: Text('City One')),
                    DataColumn(label: Text('City Two')),
                    DataColumn(label: Text('City One Areas')),
                    DataColumn(label: Text('City Two Areas')),
                    DataColumn(label: Text('Advance Price')),
                    DataColumn(label: Text('Prices')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows:
                      locations.map((loc) {
                        return DataRow(
                          cells: [
                            DataCell(Text(loc['cityOne']!)),
                            DataCell(Text(loc['cityTwo']!)),
                            DataCell(Text(loc['cityOneAreas']!)),
                            DataCell(Text(loc['cityTwoAreas']!)),
                            DataCell(Text(loc['advancePrice']!)),
                            DataCell(Text(loc['pricesCombined']!)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: greencolor,
                                    ),
                                    onPressed: () {
                                      _showEditLocationDialog(
                                        context,
                                        loc['id']!,
                                        loc['originalData']
                                            as Map<String, dynamic>,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await ref
                                          .read(locationActionsProvider)
                                          .deleteLocation(
                                            documentId: loc['id']!,
                                          );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
