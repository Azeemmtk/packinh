import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entity/hostel_room_data.dart';
import '../../domain/repository/room_availability_repository.dart';
import '../datasource/room _availability_remote_data_source.dart';

class RoomAvailabilityRepositoryImpl implements RoomAvailabilityRepository {
  final RoomAvailabilityRemoteDataSource remoteDataSource;

  RoomAvailabilityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HostelRoomData>>> fetchRoomAvailability() async {
    try {
      final hostelRoomData = await remoteDataSource.fetchRoomAvailability();
      return Right(hostelRoomData);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch room availability: $e'));
    }
  }
}