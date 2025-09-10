import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/utils/enums.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/description_preview_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/hostel_facility_name_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/review_room_section.dart';

import 'hostel_action_button.dart';

class HostelDetailsTab extends StatelessWidget {
  final HostelEntity hostel;
  const HostelDetailsTab({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HostelFacilityNameSection(hostel: hostel),
          DescriptionPreviewSection(
            description: hostel.description,
            ownerName: hostel.ownerName,
            contactNumber: hostel.contactNumber,
            smallImageUrls: hostel.smallImageUrls,
          ),
          ReviewRoomSection(rooms: hostel.rooms),
          Row(
            children: [
              Text(
                'Status: ${hostel.status.value}',
                style: TextStyle(
                  fontSize: 16,
                  color: _getStatusColor(hostel.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          height20,
          HostelActionButtons(hostel: hostel),
        ],
      ),
    );
  }

  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.approved:
        return mainColor;
      case Status.blocked:
        return Colors.grey;
      case Status.rejected:
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
