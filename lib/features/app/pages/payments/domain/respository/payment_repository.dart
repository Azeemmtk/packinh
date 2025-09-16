import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import '../../data/model/payment_model.dart';

abstract class PaymentRepository{
  Future<Either<Failure, void>> rentPaid(String paymentId);
  Future<Either<Failure, List<PaymentModel>>> getRent();
  Future<Either<Failure, void>> updatePayment(String id, Map<String, dynamic> updatedPayments);

}