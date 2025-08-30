import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/wallet/data/model/payment_model.dart';
import 'package:packinh/features/app/pages/wallet/presentation/screens/payment_edit_screen.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../provider/bloc/rent_bloc.dart';
import '../widgets/payment_summery_details_widget.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(title: 'Payment'),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      payment.hostelName,
                      style: TextStyle(
                        fontSize: 25,
                        color: headingTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => BlocProvider.value(
                              value: context.read<RentBloc>(),
                              child: PaymentEditScreen(payments: payment),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Edit 📝',
                        style: TextStyle(
                          fontSize: 25,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.07),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget(title: 'Due date'),
                        Text(payment.dueDate.toString().substring(0, 10)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TitleTextWidget(title: 'Current date'),
                        Text(DateTime.now().toString().substring(0, 10)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.07),
                PaymentSummeryDetailsWidget(payment: payment,),
                SizedBox(height: height * 0.15),
                CustomGreenButtonWidget(
                  name: 'Go back',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}