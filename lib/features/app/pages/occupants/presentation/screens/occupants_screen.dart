import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/occupants/presentation/widgets/hostel_card_widget.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';

import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_state.dart';

class OccupantsScreen extends StatelessWidget {
  const OccupantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyHostelsBloc, MyHostelsState>(
      builder: (context, state) {
        if (state is MyHostelsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyHostelsLoaded) {
          final hostels = state.hostels; // List<HostelModel>
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWidget(
                title: 'Occupants',
                enableChat: true,
              ),
              height10,
              TitleTextWidget(title: '  Your Hostels'),
              height10,
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return HostelCardWidget(hostel: hostels[index]);
                  },
                  separatorBuilder: (context, index) => height20,
                  itemCount: hostels.length,
                ),
              ),
            ],
          );
        } else if (state is MyHostelsError) {
          return Center(child: Text(state.message));
        } else {
          // Fetch the current user's ID
          final userId = FirebaseAuth.instance.currentUser?.uid;
          if (userId != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              BlocProvider.of<MyHostelsBloc>(context).add(FetchMyHostels(userId));
            });
          } else {
            return const Center(child: Text('Please log in to view hostels'));
          }
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}