import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/hostel_details/review_container.dart';

import '../../provider/bloc/review/review_bloc.dart';

class HostelReviewsTab extends StatelessWidget {
  final String hostelId;
  const HostelReviewsTab({super.key, required this.hostelId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: BlocConsumer<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewAdded) {
            context.read<ReviewBloc>().add(FetchReviews(hostelId));
          }
        },
        builder: (context, state) {
          if (state is ReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ReviewLoaded) {
            return state.reviews.isNotEmpty
                ? Column(
              children: state.reviews
                  .map((r) => ReviewContainer(review: r))
                  .toList(),
            )
                : const Center(child: Text('No reviews yet'));
          } else if (state is ReviewError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No reviews yet'));
        },
      ),
    );
  }
}
