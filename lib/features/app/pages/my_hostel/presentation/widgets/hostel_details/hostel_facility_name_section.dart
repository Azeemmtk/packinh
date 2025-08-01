import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'facility_container.dart';

class HostelFacilityNameSection extends StatelessWidget {
  final HostelEntity hostel;

  const HostelFacilityNameSection({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            hostel.mainImageUrl ?? '',
            width: double.infinity,
            height: height * 0.3,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: height * 0.3,
              color: textFieldColor,
              child: const Center(child: Text('No Image')),
            ),
          ),
        ),
        height20,
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: hostel.facilities
              .map((facility) => FacilityContainer(facility: facility))
              .toList(),
        ),
        height20,
        Text(
          hostel.name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: headingTextColor),
        ),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.locationDot,
              color: mainColor,
              size: 22,
            ),
            Text(
              hostel.placeName,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}