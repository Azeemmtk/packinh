import 'package:dartz/dartz.dart';
import '../../../../../../core/entity/hostel_entity.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entity/expense.dart';
import '../../domain/repository/expense_repository.dart';
import '../datasource/expense_remote_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HostelEntity>>> fetchHostels() async {
    try {
      final hostels = await remoteDataSource.fetchHostels();
      return Right(hostels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> fetchExpenses(List<String> hostelIds) async {
    try {
      final expenses = await remoteDataSource.fetchExpenses(hostelIds);
      return Right(expenses);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense(Expense expense) async {
    try {
      await remoteDataSource.addExpense(expense);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    try {
      await remoteDataSource.deleteExpense(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}