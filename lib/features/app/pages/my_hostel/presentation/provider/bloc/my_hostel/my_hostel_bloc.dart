import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/delete_hostel.dart';

import '../../../../domain/usecases/get_hostel_by_owner.dart';
import 'my_hostel_event.dart';
import 'my_hostel_state.dart';

class MyHostelsBloc extends Bloc<MyHostelsEvent, MyHostelsState> {
  final GetHostelsByOwner getHostelsByOwner;
  final DeleteHostel deleteHostel;

  MyHostelsBloc({required this.getHostelsByOwner, required this.deleteHostel})
      : super(MyHostelsInitial()) {
    on<FetchMyHostels>(_onFetchMyHostels);
    on<DeleteHostelEvent>(_onDeleteHostel);
  }

  Future<void> _onFetchMyHostels(
      FetchMyHostels event, Emitter<MyHostelsState> emit) async {
    emit(MyHostelsLoading());
    final result = await getHostelsByOwner(event.ownerId);
    result.fold(
      (failure) => emit(MyHostelsError(failure.message)),
      (hostels) => emit(MyHostelsLoaded(hostels)),
    );
  }

  Future<void> _onDeleteHostel(
      DeleteHostelEvent event, Emitter<MyHostelsState> emit) async {
    emit(MyHostelsLoading());
    final result =
        await deleteHostel(DeleteHostelParams(hostelId: event.hostelId));
    result.fold(
      (failure) => emit(MyHostelsDeletedError(failure.message)),
      (_) => emit(MyHostelsDeleted()),
    );
  }
}
