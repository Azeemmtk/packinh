import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entity/report_entity.dart';
import '../../../../domain/usecases/fetch_user_report_use_case.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final FetchUserReportsUseCase fetchUserReportsUseCase;

  ReportBloc({
    required this.fetchUserReportsUseCase,
  }) : super(ReportInitial()) {
    on<FetchUserReportsEvent>(_onFetchUserReports);
  }

  Future<void> _onFetchUserReports(FetchUserReportsEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    final result = await fetchUserReportsUseCase();
    emit(result.fold(
          (failure) => ReportError(message: failure.message),
          (reports) => ReportLoaded(reports: reports),
    ));
  }
}