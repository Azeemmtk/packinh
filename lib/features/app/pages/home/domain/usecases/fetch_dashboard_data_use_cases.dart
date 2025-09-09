import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entity/dashboard_data.dart';
import '../repository/dashboard_repository.dart';

class FetchDashboardDataUseCase implements UseCaseNoParams<DashboardData> {
  final DashboardRepository repository;

  FetchDashboardDataUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardData>> call() async {
    return await repository.fetchDashboardData();
  }
}