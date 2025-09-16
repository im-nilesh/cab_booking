import 'package:cab_booking_admin/widgets/add_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_table.dart';
import '../utils/constants.dart'; // Import your constants

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _filterLocations(String query) {
    setState(() {
      _searchQuery = query.trim().toLowerCase();
    });
  }

  // Function to show the Add Location Dialog
  void _showAddLocationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddLocationDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: _filterLocations,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greencolor, // Use your constant
                    foregroundColor: whiteColor, // Use your constant
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _showAddLocationDialog, // Call the dialog function
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
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('locations')
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No locations found.'));
                }

                final locations =
                    snapshot.data!.docs
                        .map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          // Extracting prices from the 'prices' map
                          final Map<String, dynamic> prices =
                              data['prices'] ?? {};

                          return {
                            'id': doc.id, // Important for edit/delete
                            'cityOne': data['cityOne'] ?? '',
                            'cityTwo': data['cityTwo'] ?? '',
                            'cityOneAreas':
                                (data['cityOneAreas'] as List<dynamic>?)?.join(
                                  ', ',
                                ) ??
                                '',
                            'cityTwoAreas':
                                (data['cityTwoAreas'] as List<dynamic>?)?.join(
                                  ', ',
                                ) ??
                                '',
                            'advancePrice': data['advancePrice'] ?? '',
                            'sedanPrice': prices['sedan'] ?? '',
                            'hatchbackPrice': prices['hatchback'] ?? '',
                            'suvErtigaPrice': prices['suvErtiga'] ?? '',
                            'xyloPrice': prices['xylo'] ?? '',
                            // You might want to combine these into a single 'prices' string for display
                            'pricesCombined':
                                'S: ${prices['sedan'] ?? ''}, H: ${prices['hatchback'] ?? ''}, E: ${prices['suvErtiga'] ?? ''}, X: ${prices['xylo'] ?? ''}',
                          };
                        })
                        .where((loc) {
                          return loc['cityOne']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              loc['cityTwo']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              loc['cityOneAreas']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              loc['cityTwoAreas']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              loc['pricesCombined']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              loc['advancePrice']!.toLowerCase().contains(
                                _searchQuery,
                              );
                        })
                        .toList();

                return CustomDataTable(
                  columns: const [
                    DataColumn(label: Text('City One')),
                    DataColumn(label: Text('City Two')),
                    DataColumn(label: Text('City One Areas')),
                    DataColumn(label: Text('City Two Areas')),
                    DataColumn(label: Text('Advance Price')),
                    DataColumn(
                      label: Text('Prices'),
                    ), // Now shows combined prices
                    DataColumn(label: Text('Actions')),
                  ],
                  rows:
                      locations.asMap().entries.map((entry) {
                        final index = entry.key;
                        final loc = entry.value;
                        return DataRow(
                          cells: [
                            DataCell(Text(loc['cityOne']!)),
                            DataCell(Text(loc['cityTwo']!)),
                            DataCell(Text(loc['cityOneAreas']!)),
                            DataCell(Text(loc['cityTwoAreas']!)),
                            DataCell(Text(loc['advancePrice']!)),
                            DataCell(
                              Text(loc['pricesCombined']!),
                            ), // Display combined prices
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: greencolor, // Use your constant
                                    ),
                                    onPressed: () {
                                      // TODO: Implement Edit location logic using loc['id'] and loc data
                                      print('Edit ${loc['id']}');
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      // TODO: Implement Delete location logic using loc['id']
                                      print('Delete ${loc['id']}');
                                      await FirebaseFirestore.instance
                                          .collection('locations')
                                          .doc(loc['id'])
                                          .delete();
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
            ),
          ),
        ],
      ),
    );
  }
}
