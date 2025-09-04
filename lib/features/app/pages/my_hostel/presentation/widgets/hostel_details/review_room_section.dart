import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/available_room_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/review_container.dart';

class ReviewRoomSection extends StatelessWidget {
  final List<Map<String, dynamic>> rooms;

  const ReviewRoomSection({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const TitleTextWidget(title: 'Rooms'),
        height10,
        ...rooms.map((room) => AvailableRoomWidget(
          room: room,
        )),
        height5,
        height20,
      ],
    );
  }
}