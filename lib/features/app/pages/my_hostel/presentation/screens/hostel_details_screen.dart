import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/hostel_facility_name_section.dart';
import '../provider/bloc/my_hostel/my_hostel_state.dart';
import '../widgets/hostel_details/description_preview_section.dart';
import '../widgets/hostel_details/review_room_section.dart';

class HostelDetailsScreen extends StatelessWidget {
  final HostelEntity hostel;

  const HostelDetailsScreen({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(
            title: hostel.name,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HostelFacilityNameSection(
                      hostel: hostel,
                    ),
                    DescriptionPreviewSection(
                      description: hostel.description,
                      ownerName: hostel.ownerName,
                      contactNumber: hostel.contactNumber,
                      smallImageUrls: hostel.smallImageUrls,
                    ),
                    ReviewRoomSection(
                      rooms: hostel.rooms,
                    ),
                    Row(
                      children: [
                        Text(
                          'Status: ${hostel.approved ? 'Approved' : 'Pending'}',
                          style: TextStyle(
                            fontSize: 16,
                            color: hostel.approved ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    height20,
                    CustomGreenButtonWidget(
                      name: 'Edit details',
                      onPressed: () {
                        // TODO: Implement edit functionality
                      },
                    ),
                    height20,
                    BlocConsumer<MyHostelsBloc, MyHostelsState>(
                      listener: (context, state) {
                        if (state is MyHostelsDeleted) {
                          Navigator.pop(context);
                          context.read<MyHostelsBloc>().add((FetchMyHostels(CurrentUser().uId!)));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Hostel approved successfully')),
                          );
                        } else if (state is MyHostelsDeletedError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomGreenButtonWidget(
                          name: 'Delete',
                          color: Colors.redAccent,
                          onPressed: () {
                            context.read<MyHostelsBloc>().add(DeleteHostelEvent(hostelId: hostel.id));
                          },
                          isLoading: state is MyHostelsLoading,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
