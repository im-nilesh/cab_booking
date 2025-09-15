import 'package:cab_booking_admin/widgets/custom_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _filterDrivers(String query) {
    setState(() {
      _searchQuery = query.trim().toLowerCase();
    });
  }

  void _showDocumentDialog(
    BuildContext context,
    String storagePath,
    String docName,
  ) async {
    String? imageUrl;
    try {
      imageUrl =
          await FirebaseStorage.instance.ref(storagePath).getDownloadURL();
    } catch (e) {
      imageUrl = null;
    }

    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    docName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (imageUrl != null)
                  Image.network(imageUrl, fit: BoxFit.contain)
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Unable to load image.'),
                  ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            controller: _searchController,
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
            onChanged: _filterDrivers,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('drivers').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No drivers found.'));
                }

                final drivers =
                    snapshot.data!.docs
                        .map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return {
                            'firstName': data['firstName'] ?? '',
                            'lastName': data['lastName'] ?? '',
                            'phone': data['phone'] ?? '',
                            'age': data['age']?.toString() ?? '',
                            'vehicleNumber': data['vehicleNumber'] ?? '',
                            'status': data['status'] ?? 'active',
                            'rc_path': data['rc_path'],
                            'pollution_certificate_path':
                                data['pollution_certificate_path'],
                            'number_plate_path': data['number_plate_path'],
                            'insurance_copy_path': data['insurance_copy_path'],
                            'driving_license_path':
                                data['driving_license_path'],
                          };
                        })
                        .where((driver) {
                          return driver['firstName']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              driver['lastName']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              driver['phone']!.contains(_searchQuery) ||
                              driver['vehicleNumber']!.toLowerCase().contains(
                                _searchQuery,
                              );
                        })
                        .toList();

                final Map<String, String> docLabels = {
                  'rc_path': 'RC',
                  'pollution_certificate_path': 'Pollution Certificate',
                  'number_plate_path': 'Number Plate',
                  'insurance_copy_path': 'Insurance Copy',
                  'driving_license_path': 'Driving License',
                };

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
                      drivers.asMap().entries.map((entry) {
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
                                    driver['age'],
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
                            DataCell(
                              Row(
                                children:
                                    docLabels.entries.map((entry) {
                                      final docKey = entry.key;
                                      final docLabel = entry.value;
                                      final docUrl = driver[docKey];
                                      if (docUrl != null &&
                                          docUrl.toString().isNotEmpty) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0,
                                          ),
                                          child: Tooltip(
                                            message: docLabel,
                                            child: InkWell(
                                              onTap:
                                                  () => _showDocumentDialog(
                                                    context,
                                                    docUrl,
                                                    docLabel,
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
                                        // Show a placeholder for missing docs to keep icon count/spacing consistent
                                        return const SizedBox(width: 26);
                                      }
                                    }).toList(),
                              ),
                            ),
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
            ),
          ),
        ],
      ),
    );
  }
}
