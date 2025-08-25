import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/occupant_entity.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repository/occupant_repository.dart';

class GetOccupantById extends UseCase<OccupantEntity, String> {
  final OccupantsRepository repository;

  GetOccupantById(this.repository);

  @override
  Future<Either<Failure, OccupantEntity>> call(String params) {
    return repository.getOccupantById(params);
  }
}