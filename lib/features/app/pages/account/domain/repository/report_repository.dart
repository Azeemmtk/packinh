import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/report_entity.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<ReportEntity>>> fetchReportsBySenderId();
}
