import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/home/presentation/widgets/build_status_card.dart';
import '../provider/bloc/dashboard/dashboard_bloc.dart';
import '../widgets/home_custom_appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(FetchDashboardData()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            const HomeCustomAppbarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is DashboardLoaded) {
                        final data = state.dashboardData;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // First row: 2 cards
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: BuildStatusCard(
                                      icon: Icons.people_alt_outlined,
                                      value: data.occupantsCount.toString(),
                                      label: 'Occupants',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: BuildStatusCard(
                                      icon: Icons.person,
                                      value: data.rentPaidCount.toString(),
                                      label: 'Rent paid',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Second row: 2 cards
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: BuildStatusCard(
                                      icon: Icons.person,
                                      value: data.rentPendingCount.toString(),
                                      label: 'Rent pending',
                                      pending: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    child: BuildStatusCard(
                                      icon: Icons.money,
                                      value: data.receivedAmount.toString(),
                                      label: 'Received amount',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Third row: 1 card centered
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: FractionallySizedBox(
                                    widthFactor: 0.5,
                                    child: BuildStatusCard(
                                      icon: Icons.money,
                                      value: data.pendingAmount.toString(),
                                      label: 'Pending amount',
                                      pending: true,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            height20,
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: TitleTextWidget(title: "Revenue"),
                            ),
                          ],
                        );
                      } else if (state is DashboardError) {
                        return Center(child: Text(state.message));
                      }
                      return const Center(child: Text('No data available'));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}