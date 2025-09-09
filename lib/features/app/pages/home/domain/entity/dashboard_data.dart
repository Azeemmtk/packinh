import 'package:equatable/equatable.dart';

class DashboardData extends Equatable {
  final int occupantsCount;
  final int rentPaidCount;
  final int rentPendingCount;
  final double receivedAmount;
  final double pendingAmount;
  final double expenses;

  const DashboardData({
    required this.occupantsCount,
    required this.rentPaidCount,
    required this.rentPendingCount,
    required this.receivedAmount,
    required this.pendingAmount,
    required this.expenses,
  });

  @override
  List<Object> get props => [
    occupantsCount,
    rentPaidCount,
    rentPendingCount,
    receivedAmount,
    pendingAmount,
    expenses,
  ];
}