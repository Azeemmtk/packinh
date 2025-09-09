import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/screens/hostel_details_screen.dart';
import '../../../../../../core/services/current_user.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../provider/bloc/my_hostel/my_hostel_event.dart';
import '../provider/bloc/my_hostel/my_hostel_state.dart';
import '../widgets/custom_my_hostel_card.dart';

class MyHostelsScreen extends StatelessWidget {
  const MyHostelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBarWidget(
          title: 'My Hostels',
          enableChat: true,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<MyHostelsBloc>()
                  .add(FetchMyHostels(CurrentUser().uId ?? ''));
              return Future.delayed(const Duration(seconds: 1));
            },
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
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HostelDetailsScreen(
                                    hostelId: hostel.id,
                                  ),
                                ));
                          },
                          child: CustomMyHostelCard(
                            imageUrl: hostel.mainImageUrl ?? '',
                            title: hostel.name,
                            location: hostel.placeName,
                            rent: hostel.rooms.isNotEmpty
                                ? (hostel.rooms[0]['rate'] as double).toInt()
                                : 0,
                            rating: hostel.rating ?? 0.0,
                            distance: 0,
                            status: hostel.status,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => height20,
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
        ),
      ],
    );
  }
}
