import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/occupant_entity.dart';

abstract class OccupantsRepository {
  Future<Either<Failure, List<OccupantEntity>>> getOccupantsByHostelId(String hostelId);
  Future<Either<Failure, OccupantEntity>> getOccupantById(String occupantId);
}