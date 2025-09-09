part of 'room_availability_bloc.dart';

abstract class RoomAvailabilityEvent extends Equatable {
  const RoomAvailabilityEvent();

  @override
  List<Object> get props => [];
}

class FetchRoomAvailability extends RoomAvailabilityEvent {}