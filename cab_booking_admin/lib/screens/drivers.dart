import 'package:cab_booking_admin/provider/driver_provider.dart';
import 'package:cab_booking_admin/components/dialog_document.dart';
import 'package:cab_booking_admin/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriversPage extends ConsumerWidget {
  const DriversPage({super.key});

  // Helper function to build a DataCell for documents
  DataCell _buildDocCells(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> driver,
  ) {
    final Map<String, String> docLabels = {
      'rc_path': 'RC',
      'pollution_certificate_path': 'Pollution Certificate',
      'number_plate_path': 'Number Plate',
      'insurance_copy_path': 'Insurance Copy',
      'driving_license_path': 'Driving License',
    };

    return DataCell(
      Row(
        children:
            docLabels.entries.map((entry) {
              final docKey = entry.key;
              final docLabel = entry.value;
              final docPath = driver['docs'][docKey];

              if (docPath != null && docPath.toString().isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Tooltip(
                    message: docLabel,
                    child: InkWell(
                      onTap:
                          () => showDialog(
                            context: context,
                            builder:
                                (_) => DocumentDialog(
                                  storagePath: docPath,
                                  docName: docLabel,
                                ),
                          ),
                      child: const Icon(
                        Icons.insert_drive_file,
                        size: 22,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(width: 26);
              }
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredDrivers = ref.watch(filteredDriversProvider);
    final driversAsyncValue = ref.watch(driversStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Drivers",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search drivers...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
            ),
            onChanged: (query) {
              ref.read(driversSearchQueryProvider.notifier).state = query;
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: driversAsyncValue.when(
              data: (data) {
                if (filteredDrivers.isEmpty &&
                    ref.read(driversSearchQueryProvider).isEmpty) {
                  return const Center(child: Text('No drivers found.'));
                } else if (filteredDrivers.isEmpty &&
                    ref.read(driversSearchQueryProvider).isNotEmpty) {
                  return const Center(
                    child: Text('No results for this search.'),
                  );
                }
                return CustomDataTable(
                  columns: const [
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Phone Number')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Vehicle Number')),
                    DataColumn(label: Text('Docs')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows:
                      filteredDrivers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final driver = entry.value;

                        return DataRow(
                          color: MaterialStateProperty.all(
                            index.isEven
                                ? Colors.grey.withOpacity(0.05)
                                : Colors.transparent,
                          ),
                          cells: [
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    driver['firstName']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    driver['age']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(Text(driver['lastName']!)),
                            DataCell(Text(driver['phone']!)),
                            DataCell(Text(driver['age']!)),
                            DataCell(Text(driver['vehicleNumber']!)),
                            _buildDocCells(
                              context,
                              ref,
                              driver,
                            ), // Corrected call
                            DataCell(
                              Text(
                                driver['status']!,
                                style: TextStyle(
                                  color:
                                      driver['status'] == "active"
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
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
