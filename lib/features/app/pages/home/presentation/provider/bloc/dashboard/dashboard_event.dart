part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchDashboardData extends DashboardEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const FetchDashboardData({this.fromDate, this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}