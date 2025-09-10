import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_state.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/review/review_bloc.dart';
import '../widgets/hostel_details/hostel_details_tab.dart';
import '../widgets/hostel_details/hostel_review_tab.dart';

class HostelDetailsScreen extends StatelessWidget {
  final String hostelId;

  const HostelDetailsScreen({super.key, required this.hostelId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHostelsBloc, MyHostelsState>(
      builder: (context, state) {
        if (state is MyHostelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyHostelsError) {
          return Center(child: Text(state.message));
        } else if (state is MyHostelsLoaded) {
          final hostel = state.hostels.firstWhere(
                (h) => h.id == hostelId,
            orElse: () => throw Exception('Hostel not found'),
          );

          return BlocProvider(
            create: (_) => getIt<ReviewBloc>()..add(FetchReviews(hostelId)),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: CustomAppBarWidget(title: hostel.name),
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
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          HostelDetailsTab(hostel: hostel),
                          HostelReviewsTab(hostelId: hostelId),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Fallback: fetch again if hostel missing
        context.read<MyHostelsBloc>().add(FetchMyHostels(CurrentUser().uId ?? ''));
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
