import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entity/expense.dart';
import '../../provider/bloc/expense/expense_bloc.dart';

class ExpenseListTile extends StatelessWidget {
  final Expense expense;

  const ExpenseListTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
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
  }
}
