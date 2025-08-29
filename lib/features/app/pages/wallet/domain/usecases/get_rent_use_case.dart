import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import 'package:packinh/features/app/pages/wallet/domain/respository/payment_repository.dart';

class GetRentUseCase implements UseCaseNoParams<List<PaymentModel>> {
  final PaymentRepository repository;
  GetRentUseCase(this.repository);

  @override
  Future<Either<Failure, List<PaymentModel>>> call() async {
    return await repository.getRent();
  }
}
