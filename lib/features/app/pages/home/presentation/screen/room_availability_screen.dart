import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';

import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/roomavailability/room_availability_bloc.dart';

class RoomAvailabilityScreen extends StatelessWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RoomAvailabilityBloc>()..add(FetchRoomAvailability()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBarWidget(title: 'Room availability'),
        ),
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: BlocBuilder<RoomAvailabilityBloc, RoomAvailabilityState>(
            builder: (context, state) {
              if (state is RoomAvailabilityLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RoomAvailabilityLoaded) {
                final hostels = state.hostelRoomData;
                if (hostels.isEmpty) {
                  return const Center(child: Text('No hostels found'));
                }
                return ListView.builder(
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
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
                  },
                );
              } else if (state is RoomAvailabilityError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }
}