import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:packinh/features/app/pages/wallet/presentation/provider/cubit/editpayment/edit_payment_state.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/details_row_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';

class PaymentSummeryDetailsWidget extends StatelessWidget {
  final EditPaymentState state; // Now takes state

  const PaymentSummeryDetailsWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(title: 'Payment Summary'),
        height10,
        DetailsRowWidget(
          title: 'Room rent',
          value: '₹${state.rent.toStringAsFixed(0)}',
        ),
        height10,
        DetailsRowWidget(
          title: state.extraMessage.isEmpty ? 'Extra' : state.extraMessage,
          value: '₹${state.extraAmount.toStringAsFixed(0)}',
        ),
        height10,
        DetailsRowWidget(
          title: 'Discount',
          value: '- ₹${state.discount.toStringAsFixed(0)}',
        ),
        height20,
        const DottedLine(dashLength: 10),
        height20,
        DetailsRowWidget(
          title: 'Total price',
          value: '₹${state.totalPrice.toStringAsFixed(0)}',
          isBold: true,
        ),
      ],
    );
  }
}