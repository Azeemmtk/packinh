part of 'rent_bloc.dart';

@immutable
sealed class RentState extends Equatable {
  const RentState();

  @override
  List<Object?> get props => [];
}

final class RentInitial extends RentState {}

final class RentLoading extends RentState {}

final class RentLoaded extends RentState {
  final List<PaymentModel> payments;

  const RentLoaded(this.payments);

  @override
  List<Object?> get props => [payments];
}

class RentPaidSuccess extends RentState {
  final String paymentId;

  const RentPaidSuccess(this.paymentId);

  @override
  List<Object?> get props => [paymentId];
}

class RentError extends RentState {
  final String message;

  const RentError(this.message);

  @override
  List<Object?> get props => [message];
}
