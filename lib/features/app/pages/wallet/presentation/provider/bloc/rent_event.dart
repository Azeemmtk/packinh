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

class UpdatePaymentEvent extends RentEvent{
  final String id;
  final Map<String ,dynamic> data;

  const UpdatePaymentEvent({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}
