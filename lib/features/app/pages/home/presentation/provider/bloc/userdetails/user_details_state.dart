part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState extends Equatable{
  const UserDetailsState();

  @override
  List<Object?> get props => [];

}

final class UserDetailsInitial extends UserDetailsState {}

final class UserDetailsLoading extends UserDetailsState {}

final class UserDetailsLoaded extends UserDetailsState {
  final UserModel user;
  const UserDetailsLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UserDetailsError extends UserDetailsState {
  final String message;
  const UserDetailsError({required this.message});

  @override

  List<Object?> get props => [message];
}
