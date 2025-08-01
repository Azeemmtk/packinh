import 'package:dartz/dartz.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/hostel_remote_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';
import '../../../../../../core/error/failures.dart';

class HostelRepositoryImpl implements HostelRepository {
  final HostelRemoteDataSource remoteDataSource;

  HostelRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> addHostel(HostelEntity hostel) async {
    return await remoteDataSource.addHostel(hostel);
  }

  @override
  Future<Either<Failure, List<HostelEntity>>> getHostelsByOwnerId(String ownerId) async {
    return await remoteDataSource.getHostelsByOwnerId(ownerId);
  }
}