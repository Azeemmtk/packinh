import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../domain/entity/dashboard_data.dart';
import '../../../../domain/usecases/fetch_dashboard_data_use_cases.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FetchDashboardDataUseCase fetchDashboardDataUseCase;

  DashboardBloc({required this.fetchDashboardDataUseCase})
      : super(DashboardInitial()) {
    on<FetchDashboardData>(_onFetchDashboardData);
  }

  Future<void> _onFetchDashboardData(
      FetchDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    final result = await fetchDashboardDataUseCase();
    result.fold(
          (failure) => emit(DashboardError(_mapFailureToMessage(failure))),
          (dashboardData) => emit(DashboardLoaded(dashboardData)),
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