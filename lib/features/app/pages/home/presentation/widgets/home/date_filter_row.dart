import 'package:flutter/material.dart';

class DateFilterRow extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(DateTime?, DateTime?) onDateChanged;

  const DateFilterRow({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.onDateChanged,
  });

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? (fromDate ?? DateTime.now().subtract(const Duration(days: 30)))
          : (toDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateChanged(
        isFrom ? picked : fromDate,
        isFrom ? toDate : picked,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context, true),
              child: _buildDateBox(fromDate, "From"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context, false),
              child: _buildDateBox(toDate, "To"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBox(DateTime? date, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        date == null
            ? 'Select $label Date'
            : '${date.day}/${date.month}/${date.year}',
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
