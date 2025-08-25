import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:packinh/core/entity/occupant_entity.dart';
import 'package:packinh/features/app/pages/occupants/domain/usecases/get_occupant_by_id.dart';

part 'occupant_details_event.dart';
part 'occupant_details_state.dart';

class OccupantDetailsBloc extends Bloc<OccupantDetailsEvent, OccupantDetailsState> {
  final GetOccupantById getOccupantById;

  OccupantDetailsBloc({required this.getOccupantById}) : super(OccupantDetailsInitial()) {
    on<FetchOccupantById>((event, emit) async {
      emit(OccupantDetailsLoading());
      final result = await getOccupantById(event.occupantId);
      result.fold(
            (failure) => emit(OccupantDetailsError(failure.message)),
            (occupant) => emit(OccupantDetailsLoaded(occupant)),
      );
    });
  }
}