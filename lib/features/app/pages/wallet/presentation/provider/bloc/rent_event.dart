part of 'rent_bloc.dart';

@immutable
sealed class RentEvent extends Equatable {

  const RentEvent();

  @override
  List<Object?> get props => [];
}

class GetRentEvent extends RentEvent{}

class RentPaidEvent extends RentEvent{
  final String paymentId;

  const RentPaidEvent(this.paymentId);

  @override
  List<Object?> get props => [paymentId];

}
