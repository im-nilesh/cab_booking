import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Drivers",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: _filterDrivers,
          ),
          const SizedBox(height: 16),
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
                            'vehicleNumber': data['vehicleNumber'] ?? '',
                            'created':
                                data['created'] != null
                                    ? (data['created'] as Timestamp)
                                        .toDate()
                                        .toString()
                                    : '',
                            'status': data['status'] ?? '',
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

                return Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: DataTable(
                        columnSpacing: 32,
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFFF5FAF8),
                        ),
                        dataRowColor: MaterialStateProperty.all(Colors.white),
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'First Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Last Name',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Phone Number',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Vehicle Number',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Created Date',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                        rows:
                            drivers.map((driver) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(driver['firstName']!)),
                                  DataCell(Text(driver['lastName']!)),
                                  DataCell(Text(driver['phone']!)),
                                  DataCell(Text(driver['vehicleNumber']!)),
                                  DataCell(Text(driver['created']!)),
                                  DataCell(Text(driver['status']!)),
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
