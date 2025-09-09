class Expense {
  final String id;
  final String hostelId;
  final String hostelName;
  final double amount;
  final String description;
  final DateTime date;

  Expense({
    required this.id,
    required this.hostelId,
    required this.hostelName,
    required this.amount,
    required this.description,
    required this.date,
  });
}