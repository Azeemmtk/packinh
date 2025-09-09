import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/expense.dart';
import '../repository/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<Either<Failure, void>> call(Expense expense) async {
    return await repository.addExpense(expense);
  }
}