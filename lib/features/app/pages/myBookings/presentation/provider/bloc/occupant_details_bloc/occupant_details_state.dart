part of 'occupant_details_bloc.dart';

abstract class OccupantDetailsState extends Equatable {
  const OccupantDetailsState();

  @override
  List<Object> get props => [];
}

class OccupantDetailsInitial extends OccupantDetailsState {}

class OccupantDetailsLoading extends OccupantDetailsState {}

class OccupantDetailsLoaded extends OccupantDetailsState {
  final OccupantEntity occupant;

  const OccupantDetailsLoaded(this.occupant);

  @override
  List<Object> get props => [occupant];
}

class OccupantDetailsError extends OccupantDetailsState {
  final String message;

  const OccupantDetailsError(this.message);

  @override
  List<Object> get props => [message];
}