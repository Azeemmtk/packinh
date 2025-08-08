import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/error/failures.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/update_hostel.dart';

part 'update_hostel_event.dart';
part 'update_hostel_state.dart';

class UpdateHostelBloc extends Bloc<UpdateHostelEvent, UpdateHostelState> {
  final UpdateHostel updateHostel;

  UpdateHostelBloc({required this.updateHostel}) : super(UpdateHostelInitial()) {
    on<UpdateHostelSubmitEvent>((event, emit) async {
      emit(UpdateHostelLoading());
      final result = await updateHostel(event.hostel);
      emit(result.fold(
            (failure) => UpdateHostelError(failure.message),
            (_) => UpdateHostelSuccess(),
      ));
    });
  }
}