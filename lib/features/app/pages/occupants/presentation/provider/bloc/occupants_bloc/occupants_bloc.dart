import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:packinh/core/entity/occupant_entity.dart';

import '../../../../domain/usecases/get_occupant_by_hostel_id.dart';

part 'occupants_event.dart';
part 'occupants_state.dart';

class OccupantsBloc extends Bloc<OccupantsEvent, OccupantsState> {
  final GetOccupantsByHostelId getOccupantsByHostelId;

  OccupantsBloc({required this.getOccupantsByHostelId}) : super(OccupantsInitial()) {
    on<FetchOccupantsByHostelId>((event, emit) async {
      emit(OccupantsLoading());
      final result = await getOccupantsByHostelId(event.hostelId);
      result.fold(
            (failure) => emit(OccupantsError(failure.message)),
            (occupants) => emit(OccupantsLoaded(occupants)),
      );
    });
  }
}