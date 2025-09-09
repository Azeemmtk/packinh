import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../domain/entity/expense.dart';
import '../provider/bloc/expense/expense_bloc.dart';

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
            onPressed: () => _showAddExpenseDialog(context),
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
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ExpansionTile(
                      title: TitleTextWidget(title: hostel.name),
                      children: [
                        if (expenses.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No expenses for this hostel'),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: expenses.length,
                            itemBuilder: (context, expIndex) {
                              final expense = expenses[expIndex];
                              return ListTile(
                                title: Text('Amount: ${expense.amount}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Description: ${expense.description}'),
                                    Text('Date: ${DateFormat('yyyy-MM-dd').format(expense.date)}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context.read<ExpenseBloc>().add(DeleteExpense(expense.id));
                                  },
                                ),
                              );
                            },
                          ),
                      ],
                    ),
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

  void _showAddExpenseDialog(BuildContext context) {
    final bloc = context.read<ExpenseBloc>();
    final hostels = bloc.hostels;
    if (hostels.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hostels available')));
      return;
    }

    String? selectedHostelId;
    final amountController = TextEditingController();
    final descController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('Add Expense'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  hint: const Text('Select Hostel'),
                  value: selectedHostelId,
                  items: hostels.map((hostel) => DropdownMenuItem(
                    value: hostel.id,
                    child: Text(hostel.name),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedHostelId = value;
                    });
                  },
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                ListTile(
                  title: Text('Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: dialogContext,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedHostelId == null || amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a hostel and enter an amount')),
                  );
                  return;
                }
                final hostel = hostels.firstWhere((h) => h.id == selectedHostelId);
                final expense = Expense(
                  id: '', // Will be generated by Firestore
                  hostelId: selectedHostelId!,
                  hostelName: hostel.name,
                  amount: double.tryParse(amountController.text) ?? 0.0,
                  description: descController.text,
                  date: selectedDate,
                );
                bloc.add(AddExpense(expense));
                Navigator.pop(dialogContext);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}