import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/roomavailability/room_availability_bloc.dart';
import '../widgets/room_availability_card.dart';

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
                    return RoomAvailabilityCard(hostel: hostel);
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