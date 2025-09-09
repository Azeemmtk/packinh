import 'package:dartz/dartz.dart';
import '../../../../../../core/entity/hostel_entity.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/expense.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, List<HostelEntity>>> fetchHostels();
  Future<Either<Failure, List<Expense>>> fetchExpenses(List<String> hostelIds);
  Future<Either<Failure, void>> addExpense(Expense expense);
  Future<Either<Failure, void>> deleteExpense(String id);
}