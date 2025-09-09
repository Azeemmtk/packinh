import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/expense.dart';
import '../repository/expense_repository.dart';

class FetchExpensesUseCase {
  final ExpenseRepository repository;

  FetchExpensesUseCase(this.repository);

  Future<Either<Failure, List<Expense>>> call(List<String> hostelIds) async {
    return await repository.fetchExpenses(hostelIds);
  }
}