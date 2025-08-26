part of 'occupants_bloc.dart';

abstract class OccupantsEvent extends Equatable {
  const OccupantsEvent();

  @override
  List<Object> get props => [];
}

class FetchOccupantsByHostelId extends OccupantsEvent {
  final String hostelId;

  const FetchOccupantsByHostelId(this.hostelId);

  @override
  List<Object> get props => [hostelId];
}