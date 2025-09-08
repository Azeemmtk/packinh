import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/services/cloudinary_services.dart';
import '../../domain/entity/report_entity.dart';
import '../../domain/repository/report_repository.dart';
import '../datasource/report_data_source.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportDataSource dataSource;
  final CloudinaryService cloudinaryService;

  ReportRepositoryImpl({
    required this.dataSource,
    required this.cloudinaryService,
  });

  @override
  Future<Either<Failure, List<ReportEntity>>> fetchReportsBySenderId() async {
    try {
      final reports = await dataSource.fetchReportsBySenderId();
      return Right(reports);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch user reports: $e'));
    }
  }
}