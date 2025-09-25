import 'package:flutter/material.dart';
import 'package:cab_booking_user/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DocumentCard extends StatefulWidget {
  final String title;
  final String imagePath;

  const DocumentCard({super.key, required this.title, required this.imagePath});

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  File? _selectedImage;

  /// Open bottom sheet (like ProfilePhotoPicker)
  void _openPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Update your ${widget.title}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Camera & Gallery options
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _pickerButton(
                    icon: Icons.camera_alt,
                    label: "Camera",
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                  const SizedBox(width: 30),
                  _pickerButton(
                    icon: Icons.photo,
                    label: "Gallery",
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  /// Picker button widget
  Widget _pickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: greencolor,
            child: Icon(icon, color: Colors.white, size: 26),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }

  /// Pick image
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
    if (mounted) Navigator.pop(context);
  }

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
              widget.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF237642),
              ),
            ),
            const SizedBox(height: 12),

            // Left aligned image (like before)
            Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    _selectedImage != null
                        ? Image.file(
                          _selectedImage!,
                          height: 80,
                          width: 140,
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          widget.imagePath,
                          height: 80,
                          width: 140,
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            const SizedBox(height: 12),

            // Edit button
            Align(
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                onPressed: () => _openPickerOptions(context),
                child: const Text("Edit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
