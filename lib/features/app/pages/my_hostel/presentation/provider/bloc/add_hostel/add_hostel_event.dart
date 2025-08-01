import 'package:equatable/equatable.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';

abstract class AddHostelEvent extends Equatable {
  const AddHostelEvent();

  @override
  List<Object?> get props => [];
}

class StartHostelSubmissionEvent extends AddHostelEvent {
  const StartHostelSubmissionEvent();

  @override
  List<Object?> get props => [];
}

class SubmitHostelEvent extends AddHostelEvent {
  final HostelEntity hostel;

  const SubmitHostelEvent(this.hostel);

  @override
  List<Object?> get props => [hostel];
}

class AddHostelErrorEvent extends AddHostelEvent {
  final String message;

  const AddHostelErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}