import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/features/app/pages/home/domain/entity/dashboard_data.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardData> fetchDashboardData();
}

class DashboardRemoteDataSourceImpl extends DashboardRemoteDataSource {
  final FirebaseFirestore firestore;

  DashboardRemoteDataSourceImpl({required this.firestore});

  @override
  Future<DashboardData> fetchDashboardData() async {
    try{
      final userId = CurrentUser().uId;

      //fetch hostels of the user
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
        );
      }

      int occupantCount = 0;
      final hostelIds = hostelQuery.docs
          .map(
            (doc) => doc.id,
      )
          .toList();

      for (var hostel in hostelQuery.docs) {
        final occupants = (hostel.data()['occupantsId'] as List<dynamic>?) ?? [];
        occupantCount += occupants.length;
      }

      //fetch payment of the hostel
      final paymentQuery = await firestore
          .collection('payments')
          .where('hostelId', whereIn: hostelIds)
          .get();

      Set<String> rentPaidOccupant = {};
      int rentPendingCount = 0;
      double receivedAmount = 0;
      double pendingAmount = 0;

      for(var payment in paymentQuery.docs){
        final data = payment.data();
        final isPaid = data['paymentStatus'] as bool;
        final rent = ( (data['amount']) + (data['extraAmount'] ?? 0) - (data['discount'] ?? 0)  as num).toDouble();

        if(isPaid){
          rentPaidOccupant.add(data['occupantId']);
          receivedAmount += rent;
        }else{
          rentPendingCount ++;
          pendingAmount += rent;
        }
      }
      return DashboardData(
        occupantsCount: occupantCount,
        rentPaidCount: rentPaidOccupant.length,
        rentPendingCount: rentPendingCount,
        receivedAmount: receivedAmount,
        pendingAmount: pendingAmount,
      );
    } catch (e){
      throw ServerException('Failed to fetch dashBoard data $e');
    }
  }
}
