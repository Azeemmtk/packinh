import 'package:flutter/material.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';

import '../../../domain/entity/expense.dart';
import 'expense_list_tile.dart';

class HostelExpenseCard extends StatelessWidget {
  final String hostelName;
  final String hostelId;
  final List<Expense> expenses;

  const HostelExpenseCard({
    super.key,
    required this.hostelName,
    required this.hostelId,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: TitleTextWidget(title: hostelName),
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
                return ExpenseListTile(expense: expense);
              },
            ),
        ],
      ),
    );
  }
}
