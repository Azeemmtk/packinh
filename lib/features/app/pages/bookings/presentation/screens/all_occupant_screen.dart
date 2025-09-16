import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/constants/const.dart';

import '../../../../../../core/widgets/custom_lottie.dart';
import '../provider/bloc/occupants_bloc/occupants_bloc.dart';
import '../widgets/occupant_card_widget.dart';

class AllOccupantScreen extends StatelessWidget {
  const AllOccupantScreen(
      {super.key, required this.hostelId, required this.hostelName});

  final String hostelId;
  final String hostelName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(title: hostelName),
          BlocProvider(
            create: (context) =>
                getIt<OccupantsBloc>()..add(FetchOccupantsByHostelId(hostelId)),
            child: BlocBuilder<OccupantsBloc, OccupantsState>(
              builder: (context, state) {
                if (state is OccupantsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OccupantsLoaded) {
                  if (state.occupants.isEmpty) {
                    return CustomLottie(message: 'No data',);
                  }
                  final occupants = state.occupants;
                  return Expanded(
                    child: Column(
                      children: [
                        height10,
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return OccupantCardWidget(
                                occupant: occupants[index],
                                hostelName: hostelName,
                                roomType: occupants[index].roomType!,
                              );
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
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}