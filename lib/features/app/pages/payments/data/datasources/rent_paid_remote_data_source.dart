import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/current_user.dart';
import '../model/payment_model.dart';

abstract class RentPaidRemoteDataSource {
  Future<List<PaymentModel>> getRent();
  Future<void> rentPaid(String paymentId);
  Future<void> updatePayment(String id, Map<String, dynamic> updatedPayment);
}

class RentPaidRemoteDataSourceImpl extends RentPaidRemoteDataSource {
  final FirebaseFirestore firestore;

  RentPaidRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> rentPaid(String paymentId) async {
    try {
      await firestore.collection('payments').doc(paymentId).update({
        'paymentStatus': true,
      });
    } catch (e) {
      throw ServerException('Failed to update payment status ${e.toString()}');
    }
  }

  @override
  Future<List<PaymentModel>> getRent() async {
    try {
      final String ownerId = CurrentUser().uId!;
      print('111111111111111');
      print(ownerId);
      QuerySnapshot snapshot = await firestore
          .collection('hostels')
          .where('ownerId', isEqualTo: ownerId)
          .get();
      print('222222222222');

      // If no hostels are found, return an empty list
      if (snapshot.docs.isEmpty) {
        return [];
      }

      List<String> hostelIds = snapshot.docs.map((doc) => doc.id).toList();

      // Only proceed with payments query if hostelIds is not empty
      if (hostelIds.isEmpty) {
        return [];
      }

      QuerySnapshot paymentsSnapshot = await firestore
          .collection('payments')
          .where('hostelId', whereIn: hostelIds)
          .get();

      List<PaymentModel> payments = paymentsSnapshot.docs
          .map((doc) => PaymentModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return payments;
    } catch (e) {
      throw ServerException('Failed to get payments: $e');
    }
  }

  @override
  Future<void> updatePayment(String id, Map<String, dynamic> updatedPayment) async{
    try{
      await firestore.collection('payments').doc(id).update(updatedPayment);
    } catch (e){
      throw ServerException('failed to update payment $e');
    }
  }
}
