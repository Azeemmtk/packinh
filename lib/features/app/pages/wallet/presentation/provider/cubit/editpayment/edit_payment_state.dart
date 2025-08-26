import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class EditPaymentState extends Equatable{
  final DateTime dueDate;
  final double rent;
  final String extraMessage;
  final double extraAmount;
  final double discount;

  const EditPaymentState({
    required this.rent,
    required this.discount,
    required this.dueDate,
    required this.extraAmount,
    required this.extraMessage,
  });

  double get totalPrice => rent + extraAmount - discount;

  String get formattedDueDate => DateFormat('E, d MMM').format(dueDate);
  String get formattedCurrentDate =>
      DateFormat('E, d MMM').format(DateTime.now());

  EditPaymentState copyWith({
    DateTime? dueDate,
    double? rent,
    String? extraMessage,
    double? extraAmount,
    double? discount,
  }) {
    return EditPaymentState(
      rent: rent ?? this.rent,
      discount: discount ?? this.discount,
      dueDate: dueDate ?? this.dueDate,
      extraAmount: extraAmount ?? this.extraAmount,
      extraMessage: extraMessage ?? this.extraMessage,
    );
  }

  @override
  List<Object?> get props => [dueDate, rent, extraMessage, extraAmount, discount];

}
