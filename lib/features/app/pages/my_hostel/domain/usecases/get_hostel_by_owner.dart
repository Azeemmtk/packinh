import 'package:dartz/dartz.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';

class GetHostelsByOwner {
  final HostelRepository repository;

  GetHostelsByOwner(this.repository);

  Future<Either<Failure, List<HostelEntity>>> call(String ownerId) async {
    return await repository.getHostelsByOwnerId(ownerId);
  }
}