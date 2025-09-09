import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/features/app/pages/home/domain/entity/hostel_room_data.dart';

abstract class RoomAvailabilityRemoteDataSource {
  Future<List<HostelRoomData>> fetchRoomAvailability();
}

class RoomAvailabilityRemoteDataSourceImpl implements RoomAvailabilityRemoteDataSource {
  final FirebaseFirestore firestore;

  RoomAvailabilityRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HostelRoomData>> fetchRoomAvailability() async {
    try {
      final userId = CurrentUser().uId;
      final hostelQuery = await firestore
          .collection('hostels')
          .where('ownerId', isEqualTo: userId)
          .get();

      final List<HostelRoomData> hostelRoomDataList = [];
      for (var doc in hostelQuery.docs) {
        final data = doc.data();
        final roomsData = data['rooms'] as List<dynamic>? ?? [];
        final rooms = roomsData.map((room) => Room(
          roomId: room['roomId'] as String,
          type: room['type'] as String,
          count: room['count'] as int,
          rate: (room['rate'] as num).toDouble(),
          additionalFacility: room['additionalFacility'] as String,
        )).toList();

        hostelRoomDataList.add(HostelRoomData(
          id: doc.id,
          name: data['name'] as String,
          placeName: data['placeName'] as String,
          rooms: rooms,
        ));
      }
      return hostelRoomDataList;
    } catch (e) {
      throw ServerException('Failed to fetch room availability: $e');
    }
  }
}