import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';

import '../../../../../../core/usecases/usecase.dart';

class UpdateHostel implements UseCase<void, HostelEntity> {
  final HostelRepository repository;

  UpdateHostel(this.repository);

  @override
  Future<Either<Failure, void>> call(HostelEntity hostel) async {
    return await repository.updateHostel(hostel);
  }
}