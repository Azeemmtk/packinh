part of 'occupants_bloc.dart';

abstract class OccupantsState extends Equatable {
  const OccupantsState();

  @override
  List<Object> get props => [];
}

class OccupantsInitial extends OccupantsState {}

class OccupantsLoading extends OccupantsState {}

class OccupantsLoaded extends OccupantsState {
  final List<OccupantEntity> occupants;

  const OccupantsLoaded(this.occupants);

  @override
  List<Object> get props => [occupants];
}

class OccupantsError extends OccupantsState {
  final String message;

  const OccupantsError(this.message);

  @override
  List<Object> get props => [message];
}