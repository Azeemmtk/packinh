import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import '../provider/bloc/dashboard/dashboard_bloc.dart';
import '../widgets/home/dashboard_card.dart';
import '../widgets/home/date_filter_row.dart';
import '../widgets/home/financial_chart.dart';
import '../widgets/home/home_action_buttons.dart';
import '../widgets/home/net_profil_widget.dart';
import '../widgets/home_custom_appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;

  void _onDateSelected(DateTime? from, DateTime? to) {
    setState(() {
      _fromDate = from;
      _toDate = to;
    });
    context.read<DashboardBloc>().add(
      FetchDashboardData(fromDate: _fromDate, toDate: _toDate),
    );
  }

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
            DateFilterRow(
              fromDate: _fromDate,
              toDate: _toDate,
              onDateChanged: _onDateSelected,
            ),
            height10,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is DashboardLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DashboardLoaded) {
                      final data = state.dashboardData;
                      final netProfit = data.receivedAmount - data.expenses;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DashboardCards(data: data),
                            height20,
                            FinancialChart(data: data),
                            height10,
                            NetProfitWidget(netProfit: netProfit),
                            height20,
                            HomeActionButtons(),
                          ],
                        ),
                      );
                    } else if (state is DashboardError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No data available'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
