// lib/widgets/add_location_dialog.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import "custom_location_textfield.dart";

class AddLocationDialog extends StatefulWidget {
  const AddLocationDialog({Key? key}) : super(key: key);

  @override
  State<AddLocationDialog> createState() => _AddLocationDialogState();
}

class _AddLocationDialogState extends State<AddLocationDialog> {
  final TextEditingController _cityOneController = TextEditingController();
  final TextEditingController _cityTwoController = TextEditingController();
  final TextEditingController _cityOneAreaController = TextEditingController();
  final TextEditingController _cityTwoAreaController = TextEditingController();
  final TextEditingController _sedanPriceController = TextEditingController();
  final TextEditingController _hatchbackPriceController =
      TextEditingController();
  final TextEditingController _suvErtigaPriceController =
      TextEditingController();
  final TextEditingController _xyloPriceController = TextEditingController();
  final TextEditingController _advancePriceController = TextEditingController();

  final List<String> _cityOneAreas = [];
  final List<String> _cityTwoAreas = [];

  void _addCityOneArea() {
    final area = _cityOneAreaController.text.trim();
    if (area.isNotEmpty && !_cityOneAreas.contains(area)) {
      setState(() {
        _cityOneAreas.add(area);
        _cityOneAreaController.clear();
      });
    }
  }

  void _removeCityOneArea(String area) {
    setState(() {
      _cityOneAreas.remove(area);
    });
  }

  void _addCityTwoArea() {
    final area = _cityTwoAreaController.text.trim();
    if (area.isNotEmpty && !_cityTwoAreas.contains(area)) {
      setState(() {
        _cityTwoAreas.add(area);
        _cityTwoAreaController.clear();
      });
    }
  }

  void _removeCityTwoArea(String area) {
    setState(() {
      _cityTwoAreas.remove(area);
    });
  }

  @override
  void dispose() {
    _cityOneController.dispose();
    _cityTwoController.dispose();
    _cityOneAreaController.dispose();
    _cityTwoAreaController.dispose();
    _sedanPriceController.dispose();
    _hatchbackPriceController.dispose();
    _suvErtigaPriceController.dispose();
    _xyloPriceController.dispose();
    _advancePriceController.dispose();
    super.dispose();
  }

  void _saveLocation() async {
    if (_cityOneController.text.isEmpty && _cityTwoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one city')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'cityOne': _cityOneController.text.trim(),
        'cityTwo': _cityTwoController.text.trim(),
        'cityOneAreas': _cityOneAreas,
        'cityTwoAreas': _cityTwoAreas,
        'advancePrice': _advancePriceController.text.trim(),
        'prices': {
          'sedan': _sedanPriceController.text.trim(),
          'hatchback': _hatchbackPriceController.text.trim(),
          'suvErtiga': _suvErtigaPriceController.text.trim(),
          'xylo': _xyloPriceController.text.trim(),
        },
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add location: $e')));
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: blackColor,
        ),
      ),
    );
  }

  Widget _buildChipList(List<String> areas, Function(String) onRemove) {
    if (areas.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children:
          areas
              .map(
                (area) => Chip(
                  label: Text(area, style: const TextStyle(color: whiteColor)),
                  backgroundColor: greencolor,
                  onDeleted: () => onRemove(area),
                  deleteIconColor: whiteColor,
                ),
              )
              .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Widget verticalGap = SizedBox(height: 16);
    const Widget smallVerticalGap = SizedBox(height: 8);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Location and Pricing",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              verticalGap,
              const Text(
                "Add Locations and Areas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              smallVerticalGap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "City One",
                          controller: _cityOneController,
                        ),
                        _buildSectionTitle("City One Areas"),
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Add City One Area",
                          controller: _cityOneAreaController,
                          isAreaField: true,
                          onAddArea: _addCityOneArea,
                        ),
                        _buildChipList(_cityOneAreas, _removeCityOneArea),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "City Two",
                          controller: _cityTwoController,
                        ),
                        _buildSectionTitle("City Two Areas"),
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Add City Two Area",
                          controller: _cityTwoAreaController,
                          isAreaField: true,
                          onAddArea: _addCityTwoArea,
                        ),
                        _buildChipList(_cityTwoAreas, _removeCityTwoArea),
                      ],
                    ),
                  ),
                ],
              ),
              verticalGap,
              _buildSectionTitle("Add Prices"),
              smallVerticalGap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Sedan Price",
                          controller: _sedanPriceController,
                          keyboardType: TextInputType.number,
                        ),
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Suv - Ertiga",
                          controller: _suvErtigaPriceController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Hatchback Price",
                          controller: _hatchbackPriceController,
                          keyboardType: TextInputType.number,
                        ),
                        CustomLocationTextfield(
                          // Renamed widget
                          hintText: "Xylo Price",
                          controller: _xyloPriceController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CustomLocationTextfield(
                // Renamed widget
                hintText: "Advance Price",
                controller: _advancePriceController,
                keyboardType: TextInputType.number,
              ),
              verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: grayColor2, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _saveLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greencolor,
                      foregroundColor: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
