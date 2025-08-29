import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import 'package:packinh/features/app/pages/wallet/domain/usecases/get_rent_use_case.dart';
import 'package:packinh/features/app/pages/wallet/domain/usecases/rent_paid_use_case.dart';

part 'rent_event.dart';
part 'rent_state.dart';

class RentBloc extends Bloc<RentEvent, RentState> {
  final GetRentUseCase getRentUseCase;
  final RentPaidUseCase rentPaidUseCase;

  RentBloc({required this.getRentUseCase, required this.rentPaidUseCase}) : super(RentInitial()) {
    on<GetRentEvent>(_onGetRent);
    on<RentPaidEvent>(_onRentPaid);
  }

  Future<void> _onGetRent(GetRentEvent event, Emitter<RentState> emit) async {
    emit(RentLoading());
    final result = await getRentUseCase();
    result.fold(
      (failure) => emit(RentError(failure.message)),
      (payments) => emit(RentLoaded(payments)),
    );
  }

  Future<void> _onRentPaid(RentPaidEvent event, Emitter<RentState> emit) async{
    if(state is! RentLoaded) return ;

    final currentState= state as RentLoaded;

    await rentPaidUseCase(event.paymentId);

    final updatedPayment= currentState.payments.map((payment) {
      if(payment.id == event.paymentId){
        return payment.copyWith(paymentStatus: true);
      }
      return payment;
    },).toList();
    emit(RentLoaded(updatedPayment));

  }
}
