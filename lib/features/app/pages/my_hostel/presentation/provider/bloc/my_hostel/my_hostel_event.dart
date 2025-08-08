import 'package:equatable/equatable.dart';

abstract class MyHostelsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMyHostels extends MyHostelsEvent {
  final String ownerId;
  FetchMyHostels(this.ownerId);

  @override
  List<Object?> get props => [ownerId];
}

class DeleteHostelEvent extends MyHostelsEvent {
  final String hostelId;

  DeleteHostelEvent({required this.hostelId});

  @override
  List<Object?> get props => [hostelId];
}
