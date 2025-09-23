import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:packinh/features/app/pages/payments/presentation/screens/payment_edit_screen.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../../data/model/payment_model.dart';
import '../provider/bloc/rent_bloc.dart';
import '../widgets/payment_summery_details_widget.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key, required this.payment});

  final PaymentModel payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, height * 0.18),
        child: CustomAppBarWidget(title: 'Payment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                    if (payment.paymentStatus == false)
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
                        Text(DateFormat('dd-MMM-yyyy').format(payment.dueDate)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TitleTextWidget(title: 'Current date'),
                        Text(DateFormat('dd-MMM-yyyy').format(DateTime.now())),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.07),
                PaymentSummeryDetailsWidget(payment: payment),
                SizedBox(height: height * 0.15),
                CustomGreenButtonWidget(
                  name: 'Go back',
                  onPressed: () {
                    Navigator.pop(context); // Fixed: Added navigation logic
                  },
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Add padding for keyboard
              ],
            ),
          ),
        ),
      ),
    );
  }
}