import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/occupant_entity.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../repository/occupant_repository.dart';

class GetOccupantsByHostelId extends UseCase<List<OccupantEntity>, String> {
  final OccupantsRepository repository;

  GetOccupantsByHostelId(this.repository);

  @override
  Future<Either<Failure, List<OccupantEntity>>> call(String params) {
    return repository.getOccupantsByHostelId(params);
  }
}