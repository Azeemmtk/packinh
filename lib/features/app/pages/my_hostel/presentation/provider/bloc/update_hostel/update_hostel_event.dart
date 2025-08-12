part of 'update_hostel_bloc.dart';

abstract class UpdateHostelEvent {
  const UpdateHostelEvent();
}

class UpdateHostelSubmitEvent extends UpdateHostelEvent {
  final HostelEntity hostel;

  const UpdateHostelSubmitEvent(this.hostel);
}

class UpdateHostelErrorEvent extends UpdateHostelEvent {
  final String message;

  const UpdateHostelErrorEvent(this.message);
}