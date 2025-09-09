import 'package:dartz/dartz.dart';
import 'package:packinh/features/app/pages/home/domain/entity/dashboard_data.dart';
import '../../../../../../core/error/failures.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardData>> fetchDashboardData();
}