import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/features/app/pages/wallet/data/datasources/rent_paid_remote_data_source.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import 'package:packinh/features/app/pages/wallet/domain/respository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final RentPaidRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> rentPaid(String paymentId) async {
    try {
      return Right(remoteDataSource.rentPaid(paymentId));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getRent() async {
    try {
      final payments = await remoteDataSource.getRent();
      return Right(payments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
