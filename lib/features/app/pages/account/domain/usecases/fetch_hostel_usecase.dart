import 'package:dartz/dartz.dart';
import '../../../../../../core/entity/hostel_entity.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/expense_repository.dart';

class FetchHostelsUseCase implements UseCaseNoParams<List<HostelEntity>> {
  final ExpenseRepository repository;

  FetchHostelsUseCase(this.repository);

  @override
  Future<Either<Failure, List<HostelEntity>>> call() async {
    return await repository.fetchHostels();
  }
}