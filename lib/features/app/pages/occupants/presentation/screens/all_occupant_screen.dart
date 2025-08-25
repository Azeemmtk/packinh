import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/occupants/presentation/widgets/occupant_card_widget.dart';

import '../provider/bloc/occupants_bloc/occupants_bloc.dart';

class AllOccupantScreen extends StatelessWidget {
  const AllOccupantScreen({super.key, required this.hostelId, this.hostelName});

  final String hostelId;
  final String? hostelName; // Optional, if you want to pass name

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OccupantsBloc>(),
      child: BlocBuilder<OccupantsBloc, OccupantsState>(
        builder: (context, state) {
          if (state is OccupantsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OccupantsLoaded) {
            final occupants = state.occupants;
            return Scaffold(
              body: Column(
                children: [
                  CustomAppBarWidget(
                    title: hostelName ?? 'Hostel Occupants',
                  ),
                  height10,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return OccupantCardWidget(occupant: occupants[index]);
                      },
                      separatorBuilder: (context, index) => height20,
                      itemCount: occupants.length,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is OccupantsError) {
            return Center(child: Text(state.message));
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              BlocProvider.of<OccupantsBloc>(context).add(
                  FetchOccupantsByHostelId(hostelId));
            });
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}