class DashboardData {
  final int occupantsCount;
  final int rentPaidCount;
  final int rentPendingCount;
  final double receivedAmount;
  final double pendingAmount;

  DashboardData({
    required this.occupantsCount,
    required this.rentPaidCount,
    required this.rentPendingCount,
    required this.receivedAmount,
    required this.pendingAmount,
  });
}