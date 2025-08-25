import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/details_row_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/occupants/presentation/widgets/occupant_details_appbar_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/screens/hostel_details_screen.dart';

import '../provider/bloc/occupant_details_bloc/occupant_details_bloc.dart';

class OccupantDetailsScreen extends StatelessWidget {
  final String occupantId;

  const OccupantDetailsScreen({super.key, required this.occupantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => getIt<OccupantDetailsBloc  >(),
  child: BlocBuilder<OccupantDetailsBloc, OccupantDetailsState>(
      builder: (context, state) {
        if (state is OccupantDetailsLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (state is OccupantDetailsLoaded) {
          final occupant = state.occupant;
          final guardian = occupant.guardian;
          return Scaffold(
            body: Column(
              children: [
                OccupantDetailsAppbarWidget(occupant: occupant),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height20,
                          if (guardian != null) ...[
                            TitleTextWidget(title: 'Guardian details'),
                            height10,
                            DetailsRowWidget(title: 'Name', value: guardian.name),
                            height5,
                            DetailsRowWidget(title: 'Phone', value: guardian.phone),
                            height5,
                            DetailsRowWidget(title: 'Relation', value: guardian.relation),
                          ],
                          height50,
                          TitleTextWidget(title: 'Id proof'),
                          height10,
                          Container(
                            width: double.infinity,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(occupant.idProofUrl ?? imagePlaceHolder),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          height5,
                          Container(
                            width: double.infinity,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(occupant.addressProofUrl ?? imagePlaceHolder),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          height50,
                          TitleTextWidget(title: 'Room details'),
                          height10,
                          DetailsRowWidget(
                            title: 'Hostel name',
                            value: 'Summit hostel', // Fetch from hostel if needed, hardcoded for now
                            isBold: true,
                          ),
                          height5,
                          DetailsRowWidget(title: 'Room type', value: 'Shared'), // Assume or fetch
                          height50,
                          CustomGreenButtonWidget(
                            name: 'Goto hostel',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HostelDetailsScreen(hostelId: occupant.hostelId ?? ''),
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is OccupantDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<OccupantDetailsBloc>(context).add(FetchOccupantById(occupantId));
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    ),
);
  }
}