import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entity/dashboard_data.dart';
import '../repository/dashboard_repository.dart';

class FetchDashboardDataUseCase {
  final DashboardRepository repository;

  FetchDashboardDataUseCase(this.repository);

  Future<Either<Failure, DashboardData>> call({DateTime? fromDate, DateTime? toDate}) async {
    return await repository.fetchDashboardData(fromDate: fromDate, toDate: toDate);
  }
}