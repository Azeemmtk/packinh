import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/constants/colors.dart';
import '../provider/bloc/expense/expense_bloc.dart';
import '../widgets/expense/add_expense_dialog.dart';
import '../widgets/expense/hostel_expense_card.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExpenseBloc>()..add(FetchExpensesData()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBarWidget(title: 'Expense'),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => showAddExpenseDialog(context),
            backgroundColor: mainColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ExpenseLoaded) {
              final bloc = context.read<ExpenseBloc>();
              final hostels = bloc.hostels;
              final expensesByHostel = bloc.expensesByHostel;

              if (hostels.isEmpty) {
                return const Center(child: Text('No hostels found'));
              }

              return ListView.builder(
                padding: EdgeInsets.all(padding),
                itemCount: hostels.length,
                itemBuilder: (context, index) {
                  final hostel = hostels[index];
                  final expenses = expensesByHostel[hostel.id] ?? [];
                  return HostelExpenseCard(
                    hostelName: hostel.name,
                    hostelId: hostel.id,
                    expenses: expenses,
                  );
                },
              );
            } else if (state is ExpenseError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
