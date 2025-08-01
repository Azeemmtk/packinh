import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/screens/hostel_details_screen.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../provider/bloc/my_hostel/my_hostel_event.dart';
import '../provider/bloc/my_hostel/my_hostel_state.dart';
import '../widgets/custom_my_hostel_card.dart';

class MyHostelsScreen extends StatelessWidget {
  const MyHostelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyHostelsBloc>()
        ..add(FetchMyHostels(CurrentUser().uId ?? '')),
      child: Column(
        children: [
          const CustomAppBarWidget(
            title: 'My Hostels',
            enableChat: true,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: padding, right: padding),
              child: BlocBuilder<MyHostelsBloc, MyHostelsState>(
                builder: (context, state) {
                  if (state is MyHostelsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyHostelsLoaded) {
                    if (state.hostels.isEmpty) {
                      return const Center(child: Text('No hostels found'));
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final hostel = state.hostels[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HostelDetailsScreen(hostel: hostel),
                              ),
                            );
                          },
                          child: CustomMyHostelCard(
                            imageUrl: hostel.mainImageUrl ?? '',
                            title: hostel.name,
                            location: hostel.placeName,
                            rent: hostel.rooms.isNotEmpty
                                ? (hostel.rooms[0]['rate'] as double).toInt()
                                : 0,
                            rating: 5.0, // Placeholder
                            distance: 0, // Placeholder
                            approved: hostel.approved, // New field
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => height10,
                      itemCount: state.hostels.length,
                    );
                  } else if (state is MyHostelsError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('No hostels available'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}