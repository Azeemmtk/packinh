import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/facilities_container_widget.dart';

class FacilitySection extends StatefulWidget {
  final TextEditingController facilityController;
  final String? facilityError;
  final List<String> facilities;
  final VoidCallback onAddFacility;
  final ValueChanged<String> onRemoveFacility;
  final VoidCallback? onFacilityAdded;

  const FacilitySection({
    super.key,
    required this.facilityController,
    this.facilityError,
    required this.facilities,
    required this.onRemoveFacility,
    required this.onAddFacility,
    this.onFacilityAdded,
  });

  @override
  State<FacilitySection> createState() => _FacilitySectionState();
}

class _FacilitySectionState extends State<FacilitySection> {
  String? _selectedFacility;
  final List<String> _availableFacilities = [
    'Wi-Fi',
    'Air Conditioning',
    'Parking',
    'Laundry',
    'Gym',
    'Kitchen',
    'TV',
    'Security',
    'Swimming Pool',
    'Study Room',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.79,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldColor,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: mainColor),
                    borderRadius: BorderRadius.circular(width * 0.05),
                  ),
                ),
                hint: const Text('Select Facility'),
                value: _selectedFacility,
                items: _availableFacilities
                    .where((facility) => !widget.facilities.contains(facility))
                    .map((facility) => DropdownMenuItem<String>(
                  value: facility,
                  child: Text(facility),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFacility = value;
                  });
                },
              ),
            ),
            IconButton(
              onPressed: () {
                if (_selectedFacility != null) {
                  widget.facilityController.text = _selectedFacility!;
                  widget.onAddFacility();
                  widget.onFacilityAdded?.call();
                  setState(() {
                    _selectedFacility = null;
                  });
                }
              },
              icon: Icon(Icons.add, color: mainColor),
            ),
          ],
        ),
        height10,
        if (widget.facilities.isEmpty && widget.facilityError != null)
          Text(
            widget.facilityError!,
            style: const

            TextStyle(color: Colors.red, fontSize: 12),
          ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: widget.facilities
              .map((facility) => FacilitiesContainerWidget(
            facility: facility,
            onRemove: () {
              widget.onRemoveFacility(facility);
              setState(() {}); // Trigger UI update on removal
              widget.onFacilityAdded?.call(); // Notify parent of change
            },
          ))
              .toList(),
        ),
      ],
    );
  }
}