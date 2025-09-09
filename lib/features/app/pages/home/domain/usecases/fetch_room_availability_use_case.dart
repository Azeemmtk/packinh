import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entity/hostel_room_data.dart';
import '../repository/room_availability_repository.dart';

class FetchRoomAvailabilityUseCase implements UseCaseNoParams<List<HostelRoomData>> {
  final RoomAvailabilityRepository repository;

  FetchRoomAvailabilityUseCase(this.repository);

  @override
  Future<Either<Failure, List<HostelRoomData>>> call() async {
    return await repository.fetchRoomAvailability();
  }
}