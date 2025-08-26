import 'package:flutter/material.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../widgets/payment_summery_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, this.isBooking = false, this.room, required this.occupantId});
  final Map<String, dynamic>? room;
  final bool isBooking;
  final String occupantId;

  @override
  Widget build(BuildContext context) {
    final String hostelId = room?['hostelId'] ?? '';
    final String roomId = room?['roomId'] ?? '';
    final String roomType = room?['type'] ?? '';

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
                  children: [
                    Text(
                      'Summit hostel',
                      style: TextStyle(
                        fontSize: 25,
                        color: headingTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextWidget(title: 'Due date'),
                        Text('Sun, 15 Jan')
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TitleTextWidget(title: 'Current date'),
                        Text('Sun, 15 Jan')
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                PaymentSummeryWidget(
                  isBooking: isBooking,
                ),
                SizedBox(
                  height: height * 0.15,
                ),
                CustomGreenButtonWidget(
                  name: 'Save',
                  onPressed:() {
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}