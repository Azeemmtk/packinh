import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../domain/entity/hostel_room_data.dart';
import '../../../../domain/usecases/fetch_room_availability_use_case.dart';

part 'room_availability_event.dart';
part 'room_availability_state.dart';

class RoomAvailabilityBloc extends Bloc<RoomAvailabilityEvent, RoomAvailabilityState> {
  final FetchRoomAvailabilityUseCase fetchRoomAvailabilityUseCase;

  RoomAvailabilityBloc({required this.fetchRoomAvailabilityUseCase})
      : super(RoomAvailabilityInitial()) {
    on<FetchRoomAvailability>(_onFetchRoomAvailability);
  }

  Future<void> _onFetchRoomAvailability(
      FetchRoomAvailability event, Emitter<RoomAvailabilityState> emit) async {
    emit(RoomAvailabilityLoading());
    final result = await fetchRoomAvailabilityUseCase();
    result.fold(
          (failure) => emit(RoomAvailabilityError(_mapFailureToMessage(failure))),
          (hostelRoomData) => emit(RoomAvailabilityLoaded(hostelRoomData)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case AuthFailure:
        return 'Authentication error';
      default:
        return 'Unexpected error';
    }
  }
}