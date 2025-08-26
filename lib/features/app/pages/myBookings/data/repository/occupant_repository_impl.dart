import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/occupant_entity.dart';

import '../../domain/repository/occupant_repository.dart';
import '../datasourse/occupants_remote_data_source.dart';

class OccupantsRepositoryImpl implements OccupantsRepository {
  final OccupantsRemoteDataSource remoteDataSource;

  OccupantsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId) async {
    try {
      final models = await remoteDataSource.getOccupantsByHostelId(hostelId);
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OccupantEntity>> getOccupantById(String occupantId) async {
    try {
      final model = await remoteDataSource.getOccupantById(occupantId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}