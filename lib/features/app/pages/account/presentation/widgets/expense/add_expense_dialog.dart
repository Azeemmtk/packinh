import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entity/expense.dart';
import '../../provider/bloc/expense/expense_bloc.dart';

void showAddExpenseDialog(BuildContext context) {
  final bloc = context.read<ExpenseBloc>();
  final hostels = bloc.hostels;

  if (hostels.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No hostels available')),
    );
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
                id: '',
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
