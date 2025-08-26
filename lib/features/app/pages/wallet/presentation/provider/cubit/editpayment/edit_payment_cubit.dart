import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/wallet/presentation/provider/cubit/editpayment/edit_payment_state.dart';

class EditPaymentCubit extends Cubit<EditPaymentState> {
  EditPaymentCubit()
      : super(EditPaymentState(
    dueDate: DateTime.now(), // Set to current date to avoid past date issue
    rent: 4000.0,
    extraMessage: 'Extra charge',
    extraAmount: 300.0,
    discount: 500.0,
  ));

  void updateDueDate(DateTime newDate) {
    emit(state.copyWith(dueDate: newDate));
  }

  void updateRent(double newRent) {
    emit(state.copyWith(rent: newRent));
  }

  void updateExtraMessage(String newMessage) {
    emit(state.copyWith(extraMessage: newMessage));
  }

  void updateExtraAmount(double newAmount) {
    emit(state.copyWith(extraAmount: newAmount));
  }

  void updateDiscountAmount(double newDiscount) {
    emit(state.copyWith(discount: newDiscount));
  }
}