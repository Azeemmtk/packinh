import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_text_field_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/facilities_container_widget.dart';

class FacilitySection extends StatelessWidget {
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
    required this.onAddFacility,
    required this.onRemoveFacility,
    this.onFacilityAdded,
  });

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
              child: CustomTextFieldWidget(
                text: 'Add Facility',
                controller: facilityController,
                errorText: facilityError,
                onChanged: (_) => {},
              ),
            ),
            IconButton(
              onPressed: () {
                onAddFacility();
                onFacilityAdded?.call();
              },
              icon: Icon(Icons.add, color: mainColor),
            ),
          ],
        ),
        height10,
        if (facilities.isEmpty && facilityError != null)
          Text(
            facilityError!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: facilities
              .map((facility) => FacilitiesContainerWidget(
            facility: facility,
            onRemove: () => onRemoveFacility(facility),
          ))
              .toList(),
        ),
      ],
    );
  }
}