class HostelRoomData {
  final String id;
  final String name;
  final String placeName;
  final List<Room> rooms;

  HostelRoomData({
    required this.id,
    required this.name,
    required this.placeName,
    required this.rooms,
  });
}

class Room {
  final String roomId;
  final String type;
  final int count;
  final double rate;
  final String additionalFacility;

  Room({
    required this.roomId,
    required this.type,
    required this.count,
    required this.rate,
    required this.additionalFacility,
  });
}