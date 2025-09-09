part of 'room_availability_bloc.dart';

abstract class RoomAvailabilityState extends Equatable {
  const RoomAvailabilityState();

  @override
  List<Object> get props => [];
}

class RoomAvailabilityInitial extends RoomAvailabilityState {}

class RoomAvailabilityLoading extends RoomAvailabilityState {}

class RoomAvailabilityLoaded extends RoomAvailabilityState {
  final List<HostelRoomData> hostelRoomData;

  const RoomAvailabilityLoaded(this.hostelRoomData);

  @override
  List<Object> get props => [hostelRoomData];
}

class RoomAvailabilityError extends RoomAvailabilityState {
  final String message;

  const RoomAvailabilityError(this.message);

  @override
  List<Object> get props => [message];
}