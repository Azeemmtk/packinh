import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/features/app/Navigation/cubit/bottom_nav_cubit.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/screens/my_hostels_screen.dart';
import '../../../../../core/services/current_user.dart';
import '../../../pages/bookings/presentation/screens/booking_screen.dart';
import '../../../pages/account/presentation/screens/account_screen.dart';
import '../../../pages/home/presentation/screen/home_screen.dart';
import '../../../pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../../../pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import '../../../pages/my_hostel/presentation/screens/add_hostel_screen.dart';
import '../../../pages/payments/presentation/screens/payment_screen.dart';
import '../widget/build_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget _getScreen(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return HomeScreen();
      case BottomNavItem.occupants:
        return BookingScreen();
      case BottomNavItem.myHostel:
        return MyHostelsScreen();
      case BottomNavItem.wallet:
        return WalletScreen();
      case BottomNavItem.account:
        return AccountScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, BottomNavItem>(
        builder: (context, state) {
          return Scaffold(
              body: _getScreen(state),
              bottomNavigationBar: BuildBottomNavigationBar(),
              floatingActionButton: state == BottomNavItem.myHostel
                  ? FloatingActionButton(
                      backgroundColor: mainColor,
                      onPressed: () async {
                        print("Current logged in UID: ${CurrentUser().uId}===============");
                        print("Current logged in name: ${CurrentUser().name}===============");
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddHostelScreen(),
                            ));
                        print('============$result');
                        if (result == true) {
                          print('============inside');
                          context
                              .read<MyHostelsBloc>()
                              .add(FetchMyHostels(CurrentUser().uId ?? ''));
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                  : null);
        },
      ),
    );
  }
}
