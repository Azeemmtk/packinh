import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import 'package:packinh/features/app/pages/wallet/presentation/provider/bloc/rent_bloc.dart';
import 'package:packinh/features/app/pages/wallet/presentation/screens/payment_details_screen.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';

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
            builder: (context) => PaymentDetailsScreen(
              payment: payment,
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
                          'RENT - ',
                          style: const TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          payment.amount.toString(),
                          style: TextStyle(
                            color: rentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      payment.dueDate.toString().substring(0, 10),
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
                    print('paid------------');
                    context.read<RentBloc>().add(RentPaidEvent(payment.id!));
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
