import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../repository/expense_repository.dart';

class DeleteExpenseUseCase {
  final ExpenseRepository repository;

  DeleteExpenseUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteExpense(id);
  }
}