import 'package:cab_booking_user/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePhotoPicker extends StatefulWidget {
  final String initialImage;
  final Function(File?) onImageSelected;

  const ProfilePhotoPicker({
    super.key,
    required this.initialImage,
    required this.onImageSelected,
  });

  @override
  State<ProfilePhotoPicker> createState() => _ProfilePhotoPickerState();
}

class _ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  File? _selectedImage;

  /// Opens bottom sheet (UI same as screenshot)
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
              // Top grey drag handle
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile photo",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),

              // Camera & Gallery buttons
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

  /// Picker button widget (green circle + text below)
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

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage);
    }
    if (mounted) Navigator.pop(context); // Close sheet after pick
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage:
              _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : AssetImage(widget.initialImage) as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _openPickerOptions(context),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: greencolor,
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
