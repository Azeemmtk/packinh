import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entity/hostel_room_data.dart';

abstract class RoomAvailabilityRepository {
  Future<Either<Failure, List<HostelRoomData>>> fetchRoomAvailability();
}