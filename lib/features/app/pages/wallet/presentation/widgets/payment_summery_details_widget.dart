import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/details_row_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';

class PaymentSummeryDetailsWidget extends StatelessWidget {
  final PaymentModel payment;

  const PaymentSummeryDetailsWidget({
    super.key,
    required this.payment,
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
          value: '₹${payment.amount + (payment.extraAmount ?? 0) - (payment.discount ?? 0)}',
        ),
        height10,
        DetailsRowWidget(
          title: payment.extraMessage ??' additional payment',
          value: '₹${payment.extraAmount ?? '0.0'}',
        ),
        height10,
        DetailsRowWidget(
          title: 'Discount',
          value: '- ₹${payment.discount ?? '0.0'}',
        ),
        height20,
        const DottedLine(dashLength: 10),
        height20,
        DetailsRowWidget(
          title: 'Total price',
          value: '₹${payment.amount + (payment.extraAmount ?? 0) - (payment.discount ?? 0)}',
          isBold: true,
        ),
      ],
    );
  }
}