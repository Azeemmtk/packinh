import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/utils/enums.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/hostel_facility_name_section.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../provider/bloc/my_hostel/my_hostel_state.dart';
import '../provider/bloc/review/review_bloc.dart';
import '../widgets/hostel_details/description_preview_section.dart';
import '../widgets/hostel_details/review_container.dart';
import '../widgets/hostel_details/review_room_section.dart';
import 'hostel_edit_screen.dart';

class HostelDetailsScreen extends StatelessWidget {
  final String hostelId;

  const HostelDetailsScreen({super.key, required this.hostelId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHostelsBloc, MyHostelsState>(
      builder: (context, state) {
        HostelEntity? hostel;
        if (state is MyHostelsLoaded) {
          hostel = state.hostels.firstWhere(
            (h) => h.id == hostelId,
            orElse: () => throw Exception('Hostel not found'),
          );
        } else if (state is MyHostelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyHostelsError) {
          return Center(child: Text(state.message));
        }

        if (hostel == null) {
          context
              .read<MyHostelsBloc>()
              .add(FetchMyHostels(CurrentUser().uId ?? ''));
          return const Center(child: CircularProgressIndicator());
        }

        return BlocProvider(
          create: (context) => getIt<ReviewBloc>()..add(FetchReviews(hostelId)),
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBarWidget(
                  title: hostel.name,
                ),
              ),
              body: Column(
                children: [
                  TabBar(
                    tabs: const [
                      Tab(text: 'Details'),
                      Tab(text: 'Review & Rating'),
                    ],
                    labelColor: headingTextColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: mainColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      SingleChildScrollView(
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
                                    'Status: ${hostel.status.value}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: hostel.status == Status.approved
                                          ? mainColor
                                          : hostel.status == Status.blocked
                                          ? Colors.grey
                                          : hostel.status == Status.rejected
                                          ? Colors.red
                                          : Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              height20,
                              CustomGreenButtonWidget(
                                name: 'Edit details',
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HostelEditScreen(hostel: hostel!),
                                    ),
                                  );
                                  if (result == true) {
                                    context.read<MyHostelsBloc>().add(
                                        FetchMyHostels(CurrentUser().uId ?? ''));
                                  }
                                },
                              ),
                              height20,
                              BlocConsumer<MyHostelsBloc, MyHostelsState>(
                                listener: (context, state) {
                                  if (state is MyHostelsDeleted) {
                                    Navigator.pop(context);
                                    context.read<MyHostelsBloc>().add(
                                        FetchMyHostels(CurrentUser().uId ?? ''));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Hostel deleted successfully')),
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
                                      Navigator.pop(context);
                                      context.read<MyHostelsBloc>().add(
                                          DeleteHostelEvent(
                                              hostelId: hostel!.id));
                                    },
                                    isLoading: state is MyHostelsLoading,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Builder(
                          builder: (blocContext) => BlocConsumer<ReviewBloc, ReviewState>(
                            listener: (context, state) {
                              if (state is ReviewAdded) {
                                // Refresh reviews after adding a new one
                                blocContext.read<ReviewBloc>().add(FetchReviews(hostelId));
                              }
                            },
                            builder: (context, state) {
                              print('Current ReviewBloc state: $state'); // Debugging
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  height20,
                                  const TitleTextWidget(title: 'Review and rating'),
                                  height10,
                                  if (state is ReviewLoading)
                                    const Center(child: CircularProgressIndicator())
                                  else if (state is ReviewLoaded)
                                    state.reviews.isNotEmpty
                                        ? Column(
                                      children: state.reviews
                                          .map((review) => ReviewContainer(review: review))
                                          .toList(),
                                    )
                                        : const Center(child: Text('No reviews yet'))
                                  else if (state is ReviewError)
                                      Center(child: Text('Error: ${state.message}'))
                                    else
                                      const Center(child: Text('No reviews yet')),
                                  height20,
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ])
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
