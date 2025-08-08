import 'package:dartz/dartz.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import '../../../../../../core/error/failures.dart';

abstract class HostelRepository {
  Future<Either<Failure, void>> addHostel(HostelEntity hostel);
  Future<Either<Failure, List<HostelEntity>>> getHostelsByOwnerId(String ownerId);
  Future<Either<Failure, void>> deleteHostel(String hostelId);
  Future<Either<Failure, void>> updateHostel(HostelEntity hostel);
}