import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/usecases/usecase.dart';
import 'package:packinh/features/app/pages/wallet/domain/respository/payment_repository.dart';

class UpdatePaymentUseCase extends UseCase<void, UpdateParams> {
  final PaymentRepository repository;

  UpdatePaymentUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(UpdateParams params) async {
    return await repository.updatePayment(params.id, params.data);
  }
}

class UpdateParams {
  final String id;
  final Map<String, dynamic> data;

  UpdateParams({required this.id, required this.data});
}
