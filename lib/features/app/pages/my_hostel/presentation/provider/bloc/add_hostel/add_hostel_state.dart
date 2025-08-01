import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class AddHostelState extends Equatable {
  const AddHostelState();

  @override
  List<Object?> get props => [];
}

class AddHostelInitial extends AddHostelState {}

class AddHostelLoading extends AddHostelState {}

class AddHostelSuccess extends AddHostelState {}

class AddHostelError extends AddHostelState {
  final String message;

  const AddHostelError(this.message);

  @override
  List<Object?> get props => [message];
}
