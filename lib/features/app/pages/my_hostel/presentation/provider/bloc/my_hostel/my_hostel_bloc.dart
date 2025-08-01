import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_hostel_by_owner.dart';
import 'my_hostel_event.dart';
import 'my_hostel_state.dart';

class MyHostelsBloc extends Bloc<MyHostelsEvent, MyHostelsState> {
  final GetHostelsByOwner getHostelsByOwner;

  MyHostelsBloc({required this.getHostelsByOwner}) : super(MyHostelsInitial()) {
    on<FetchMyHostels>((event, emit) async {
      emit(MyHostelsLoading());
      final result = await getHostelsByOwner(event.ownerId);
      result.fold(
            (failure) => emit(MyHostelsError(failure.message)),
            (hostels) => emit(MyHostelsLoaded(hostels)),
      );
    });
  }
}