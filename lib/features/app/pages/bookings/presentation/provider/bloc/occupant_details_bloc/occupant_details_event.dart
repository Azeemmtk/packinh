part of 'occupant_details_bloc.dart';

abstract class OccupantDetailsEvent extends Equatable {
  const OccupantDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchOccupantById extends OccupantDetailsEvent {
  final String occupantId;

  const FetchOccupantById(this.occupantId);

  @override
  List<Object> get props => [occupantId];
}