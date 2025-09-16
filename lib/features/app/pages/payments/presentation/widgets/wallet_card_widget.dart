import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_alert_dialog.dart';
import '../../data/model/payment_model.dart';
import '../provider/bloc/rent_bloc.dart';
import '../screens/payment_details_screen.dart';

class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    required this.payment,
  });

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    print(payment.amount);
    final rentStatus = payment.paymentStatus ? 'Paid' : 'Due';
    final rentColor = payment.paymentStatus ? mainColor : Colors.red;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => BlocProvider.value(
              value: context.read<RentBloc>(),
              child: PaymentDetailsScreen(
                payment: payment,
              ),
            ),
          ),
        );
      },
      child: Container(
        height: height * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                payment.occupantImage,
                width: width * 0.35,
                // height: height * 0.11,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.network(
                  imagePlaceHolder,
                  width: width * 0.35,
                  // height: height * 0.11,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is loaded
                      return child;
                    }
                    // Show shimmer while loading
                    return
                      Shimmer.fromColors(
                        baseColor: secondaryColor,
                        direction: ShimmerDirection.ltr,
                        highlightColor: mainColor,
                        child: Container(
                          width: width * 0.35,
                          color: Colors.white,
                        ),
                      );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      payment.hostelName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // const SizedBox(height: 4),
                    Text(
                      payment.occupantName,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                    // const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Amount - ',
                          style: const TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (payment.amount + (payment.extraAmount ?? 0) - (payment.discount ?? 0)).toString(),
                          style: TextStyle(
                            color: rentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      DateFormat('dd-MMM-yyyy').format(payment.dueDate),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    if (!payment.paymentStatus) {

                      bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Confirm Payment ',
                            message: 'Are you sure you want to mark this payment as paid?',
                            confirmButtonText: 'Confirm',
                          );
                        },
                      );

                      // If user confirms, update the payment status
                      if (confirm == true) {
                        context.read<RentBloc>().add(RentPaidEvent(payment.id!));
                        // Optional: Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          customSnackBar(text: 'Payment status updated successfully'),
                        );
                      }
                    }
                  },
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: mainColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}