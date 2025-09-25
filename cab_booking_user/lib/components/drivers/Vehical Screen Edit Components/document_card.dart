import 'package:flutter/material.dart';

class DocumentCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onEdit;

  const DocumentCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF237642),
              ),
            ),
            const SizedBox(height: 12),

            // Image aligned to left
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  height: 80, // smaller height for neat look
                  width: 140, // fixed width instead of full
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Edit button aligned right
            Align(
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                onPressed: onEdit,
                child: const Text('Edit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
