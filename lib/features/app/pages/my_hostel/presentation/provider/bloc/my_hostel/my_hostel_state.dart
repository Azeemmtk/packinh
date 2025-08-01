import '../../../../domain/entity/hostel_entity.dart';

abstract class MyHostelsState {}

class MyHostelsInitial extends MyHostelsState {}

class MyHostelsLoading extends MyHostelsState {}

class MyHostelsLoaded extends MyHostelsState {
  final List<HostelEntity> hostels;
  MyHostelsLoaded(this.hostels);
}

class MyHostelsError extends MyHostelsState {
  final String message;
  MyHostelsError(this.message);
}