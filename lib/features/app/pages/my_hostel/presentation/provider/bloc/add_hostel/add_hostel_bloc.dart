import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/add_hostel.dart';

import 'add_hostel_event.dart';
import 'add_hostel_state.dart';

class AddHostelBloc extends Bloc<AddHostelEvent, AddHostelState> {
  final AddHostel addHostel;

  AddHostelBloc({required this.addHostel}) : super(AddHostelInitial()) {
    on<StartHostelSubmissionEvent>(_onStartSubmission);
    on<SubmitHostelEvent>(_onSubmitHostel);
    on<AddHostelErrorEvent>(_onError);
  }

  Future<void> _onStartSubmission(
      StartHostelSubmissionEvent event, Emitter<AddHostelState> emit) async {
    emit(AddHostelLoading());
  }

  Future<void> _onSubmitHostel(
      SubmitHostelEvent event, Emitter<AddHostelState> emit) async {
    emit(AddHostelLoading());
    final result = await addHostel(event.hostel);
    emit(result.fold(
          (failure) => AddHostelError(failure.message),
          (_) => AddHostelSuccess(),
    ));
  }

  Future<void> _onError(
      AddHostelErrorEvent event, Emitter<AddHostelState> emit) async {
    emit(AddHostelError(event.message));
  }
}