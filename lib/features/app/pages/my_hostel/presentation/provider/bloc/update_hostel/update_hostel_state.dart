part of 'update_hostel_bloc.dart';

abstract class UpdateHostelState {}

class UpdateHostelInitial extends UpdateHostelState {}

class UpdateHostelLoading extends UpdateHostelState {}

class UpdateHostelSuccess extends UpdateHostelState {}

class UpdateHostelError extends UpdateHostelState {
  final String message;

  UpdateHostelError(this.message);
}