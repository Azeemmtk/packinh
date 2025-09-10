import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/current_user.dart';
import '../../domain/entity/dashboard_data.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> fetchDashboardData({DateTime? fromDate, DateTime? toDate});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore firestore;

  DashboardRemoteDataSourceImpl({required this.firestore});

  @override
  Future<DashboardData> fetchDashboardData({DateTime? fromDate, DateTime? toDate}) async {
    try {
      final userId = CurrentUser().uId;

      // Fetch hostels of the user
      final hostelQuery = await firestore
          .collection('hostels')
          .where('ownerId', isEqualTo: userId)
          .get();
      if (hostelQuery.docs.isEmpty) {
        return DashboardData(
          occupantsCount: 0,
          rentPaidCount: 0,
          rentPendingCount: 0,
          receivedAmount: 0,
          pendingAmount: 0,
          expenses: 0,
          fromDate: fromDate,
          toDate: toDate,
        );
      }

      int occupantCount = 0;
      final hostelIds = hostelQuery.docs.map((doc) => doc.id).toList();

      for (var hostel in hostelQuery.docs) {
        final occupants = (hostel.data()['occupantsId'] as List<dynamic>?) ?? [];
        occupantCount += occupants.length;
      }

      // Fetch payments of the hostel within the date range
      Query<Map<String, dynamic>> paymentQuery = firestore
          .collection('payments')
          .where('hostelId', whereIn: hostelIds);

      if (fromDate != null && toDate != null) {
        paymentQuery = paymentQuery
            .where('paymentDate', isGreaterThanOrEqualTo: Timestamp.fromDate(fromDate))
            .where('paymentDate', isLessThanOrEqualTo: Timestamp.fromDate(toDate));
      }

      final paymentQuerySnapshot = await paymentQuery.get();

      Set<String> rentPaidOccupant = {};
      int rentPendingCount = 0;
      double receivedAmount = 0;
      double pendingAmount = 0;

      for (var payment in paymentQuerySnapshot.docs) {
        final data = payment.data();
        final isPaid = data['paymentStatus'] as bool;
        final rent = ((data['amount'] as num) + (data['extraAmount'] ?? 0) - (data['discount'] ?? 0)).toDouble();

        if (isPaid) {
          rentPaidOccupant.add(data['occupantId']);
          receivedAmount += rent;
        } else {
          rentPendingCount++;
          pendingAmount += rent;
        }
      }

      // Fetch expenses for these hostels within the date range
      double expenses = 0.0;
      if (hostelIds.isNotEmpty) {
        Query<Map<String, dynamic>> expenseQuery = firestore
            .collection('expenses')
            .where('hostelId', whereIn: hostelIds);

        if (fromDate != null && toDate != null) {
          expenseQuery = expenseQuery
              .where('expenseDate', isGreaterThanOrEqualTo: Timestamp.fromDate(fromDate))
              .where('expenseDate', isLessThanOrEqualTo: Timestamp.fromDate(toDate));
        }

        final expenseQuerySnapshot = await expenseQuery.get();
        for (var doc in expenseQuerySnapshot.docs) {
          final data = doc.data();
          expenses += (data['amount'] as num?)?.toDouble() ?? 0.0;
        }
      }

      return DashboardData(
        occupantsCount: occupantCount,
        rentPaidCount: rentPaidOccupant.length,
        rentPendingCount: rentPendingCount,
        receivedAmount: receivedAmount,
        pendingAmount: pendingAmount,
        expenses: expenses,
        fromDate: fromDate,
        toDate: toDate,
      );
    } catch (e) {
      throw ServerException('Failed to fetch dashboard data: $e');
    }
  }
}