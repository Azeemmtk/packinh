import 'package:flutter/material.dart';

import '../../../../../../core/widgets/title_text_widget.dart';
import '../../domain/entity/hostel_room_data.dart';

class RoomAvailabilityCard extends StatelessWidget {
  const RoomAvailabilityCard({
    super.key,
    required this.hostel,
  });

  final HostelRoomData hostel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleTextWidget(title: hostel.name),
            Text(
              hostel.placeName,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Rooms Available:',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 5),
            ...hostel.rooms.map((room) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${room.type} (${room.additionalFacility})',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Available: ${room.count}',
                    style: TextStyle(
                      fontSize: 14,
                      color: room.count > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}