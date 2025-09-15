import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _filterUsers(String query) {
    setState(() {
      _searchQuery = query.trim().toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Users",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search users...',
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
            onChanged: _filterUsers,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                final users =
                    snapshot.data!.docs
                        .map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return {
                            'firstName': data['firstName'] ?? '',
                            'lastName': data['lastName'] ?? '',
                            'phone': data['phone_number'] ?? '',
                            'age': data['age'].toString() ?? '',
                            'created':
                                data['createdAt'] != null
                                    ? (data['createdAt'] as Timestamp)
                                        .toDate()
                                        .toString()
                                    : '',
                            'modified':
                                data['createdAt'] != null
                                    ? (data['createdAt'] as Timestamp)
                                        .toDate()
                                        .toString()
                                    : '',
                            'status': data['status'] ?? 'active',
                          };
                        })
                        .where((user) {
                          return user['firstName']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              user['lastName']!.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              user['phone']!.contains(_searchQuery);
                        })
                        .toList();

                return Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: DataTable(
                        headingRowHeight: 50,
                        dataRowHeight: 60,
                        columnSpacing: 30,
                        dividerThickness: 0.6,
                        headingRowColor: MaterialStateProperty.all(
                          Colors.green.withOpacity(0.1),
                        ),
                        dataRowColor: MaterialStateProperty.resolveWith(
                          (states) =>
                              states.contains(MaterialState.selected)
                                  ? Colors.green.withOpacity(0.05)
                                  : Colors.transparent,
                        ),
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 0.7,
                          ),
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'First Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Last Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Created Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Modified Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Status',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                        rows:
                            users.asMap().entries.map((entry) {
                              final index = entry.key;
                              final user = entry.value;

                              return DataRow(
                                color: MaterialStateProperty.all(
                                  index.isEven
                                      ? Colors.grey.withOpacity(0.05)
                                      : Colors.transparent,
                                ),
                                cells: [
                                  DataCell(
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user['firstName']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          user['age'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(user['lastName']!)),
                                  DataCell(Text(user['phone']!)),
                                  DataCell(Text(user['created']!)),
                                  DataCell(Text(user['modified']!)),
                                  DataCell(
                                    Text(
                                      user['status']!,
                                      style: TextStyle(
                                        color:
                                            user['status'] == "active"
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
