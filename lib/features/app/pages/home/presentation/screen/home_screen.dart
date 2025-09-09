import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/home/presentation/screen/room_availability_screen.dart';
import 'package:packinh/features/app/pages/home/presentation/widgets/build_status_card.dart';
import '../../../account/presentation/screens/expense_screen.dart';
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
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, height * 0.18),
          child: const HomeCustomAppbarWidget(),
        ),
        body: Column(
          children: [
            height10,
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
                        final maxY = (data.receivedAmount + data.pendingAmount + data.expenses) * 1.2;
                        final netProfit = data.receivedAmount - data.expenses;
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
                              child: TitleTextWidget(title: "Financial Overview"),
                            ),
                            // Financial Bar Chart
                            Container(
                              height: 250,
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: maxY < 1 ? 100 : maxY,
                                  minY: 0,
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      getTooltipColor: (_) => Colors.grey[800]!,
                                      tooltipPadding: const EdgeInsets.all(8),
                                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                        String label = group.x == 0
                                            ? 'Received'
                                            : group.x == 1
                                            ? 'Pending'
                                            : 'Expenses';
                                        return BarTooltipItem(
                                          '$label\n${rod.toY.toStringAsFixed(0)}',
                                          const TextStyle(color: Colors.white),
                                        );
                                      },
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) {
                                          return Text(
                                            value.toInt().toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          );
                                        },
                                        interval: maxY / 5 < 1 ? 20 : maxY / 5,
                                      ),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        getTitlesWidget: (value, meta) {
                                          String text = value.toInt() == 0
                                              ? 'Received'
                                              : value.toInt() == 1
                                              ? 'Pending'
                                              : 'Expenses';
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              text,
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(color: Colors.grey[300]!, width: 1),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawHorizontalLine: true,
                                    drawVerticalLine: false,
                                    horizontalInterval: maxY / 5 < 1 ? 20 : maxY / 5,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.grey[200],
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 0,
                                      barRods: [
                                        BarChartRodData(
                                          toY: data.receivedAmount,
                                          color: Colors.green[400],
                                          width: 25,
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                          gradient: LinearGradient(
                                            colors: [Colors.green[600]!, Colors.green[300]!],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 1,
                                      barRods: [
                                        BarChartRodData(
                                          toY: data.pendingAmount,
                                          color: Colors.red[400],
                                          width: 25,
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                          gradient: LinearGradient(
                                            colors: [Colors.red[600]!, Colors.red[300]!],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 2,
                                      barRods: [
                                        BarChartRodData(
                                          toY: data.expenses,
                                          color: Colors.blue[400],
                                          width: 25,
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                          gradient: LinearGradient(
                                            colors: [Colors.blue[600]!, Colors.blue[300]!],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            height10,
                            // Net Profit/Loss
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Net Profit/Loss:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    netProfit >= 0
                                        ? '+${netProfit.toStringAsFixed(0)}'
                                        : netProfit.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: netProfit >= 0 ? Colors.green[600] : Colors.red[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            height20,
                            // Room Availability Button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RoomAvailabilityScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'View Room Availability',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            height10,
                            // Expenses Button
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ExpenseScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'View Expenses',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
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