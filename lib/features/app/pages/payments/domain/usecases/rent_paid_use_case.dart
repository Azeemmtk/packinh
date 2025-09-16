import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';

import '../respository/payment_repository.dart';

class RentPaidUseCase implements UseCase<void, String> {
  final PaymentRepository repository;
  RentPaidUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.rentPaid(params);
  }
}
