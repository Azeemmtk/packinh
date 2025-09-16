import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import '../../../my_hostel/presentation/provider/bloc/my_hostel/my_hostel_state.dart';
import '../widgets/hostel_card_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      BlocProvider.of<MyHostelsBloc>(context).add(FetchMyHostels(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarWidget(
          title: 'Bookings',
          enableChat: true,
        ),
        height10,
        BlocBuilder<MyHostelsBloc, MyHostelsState>(
          builder: (context, state) {
            if (state is MyHostelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyHostelsLoaded) {
              if (state.hostels.isEmpty) {
                return const Center(child: Text('Add hostels'));
              }
              final hostels = state.hostels;
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                ),
              );
            } else if (state is MyHostelsError) {
              return Center(child: Text(state.message));
            } else {
              // Handle initial state or user not logged in
              final userId = FirebaseAuth.instance.currentUser?.uid;
              if (userId == null) {
                return const Center(child: Text('Please log in to view hostels'));
              }
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}