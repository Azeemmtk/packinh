import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart'; // Add this import for Save button
import 'package:packinh/core/widgets/custom_text_field_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/features/app/pages/wallet/presentation/provider/cubit/editpayment/edit_payment_cubit.dart';

class PaymentEditScreen extends StatefulWidget {
  const PaymentEditScreen({super.key});

  @override
  State<PaymentEditScreen> createState() => _PaymentEditScreenState();
}

class _PaymentEditScreenState extends State<PaymentEditScreen> {
  late TextEditingController dueDateController;
  late TextEditingController rentController;
  late TextEditingController extraMessageController;
  late TextEditingController extraAmountController;
  late TextEditingController discountAmountController;

  @override
  void initState() {
    super.initState();
    final state = context.read<EditPaymentCubit>().state;
    dueDateController = TextEditingController(text: state.formattedDueDate);
    rentController = TextEditingController(text: state.rent.toStringAsFixed(2));
    extraMessageController = TextEditingController(text: state.extraMessage);
    extraAmountController = TextEditingController(text: state.extraAmount.toStringAsFixed(2));
    discountAmountController = TextEditingController(text: state.discount.toStringAsFixed(2));
  }

  @override
  void dispose() {
    dueDateController.dispose();
    rentController.dispose();
    extraMessageController.dispose();
    extraAmountController.dispose();
    discountAmountController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: context.read<EditPaymentCubit>().state.dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      dueDateController.text = DateFormat('E, d MMM').format(picked);
      context.read<EditPaymentCubit>().updateDueDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(title: 'Edit payment'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TitleTextWidget(title: 'Due date'),
                    GestureDetector(
                      onTap: () => _pickDueDate(context),
                      child: AbsorbPointer(
                        child: CustomTextFieldWidget(
                          hintText: 'Due date',
                          fieldName: 'Due date',
                          controller: dueDateController,
                        ),
                      ),
                    ),
                    height10,
                    TitleTextWidget(title: 'Rent'),
                    CustomTextFieldWidget(
                      hintText: 'Rent',
                      fieldName: 'Rent',
                      controller: rentController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final double? parsed = double.tryParse(value);
                        if (parsed != null) {
                          context.read<EditPaymentCubit>().updateRent(parsed);
                        }
                      },
                    ),
                    height10,
                    TitleTextWidget(title: 'Extra message'),
                    CustomTextFieldWidget(
                      hintText: 'Enter message',
                      fieldName: 'Extra message',
                      controller: extraMessageController,
                      onChanged: (value) {
                        context.read<EditPaymentCubit>().updateExtraMessage(value);
                      },
                    ),
                    height10,
                    TitleTextWidget(title: 'Extra amount'),
                    CustomTextFieldWidget(
                      hintText: 'Extra amount',
                      fieldName: 'Extra amount',
                      controller: extraAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final double? parsed = double.tryParse(value);
                        if (parsed != null) {
                          context.read<EditPaymentCubit>().updateExtraAmount(parsed);
                        }
                      },
                    ),
                    height10,
                    TitleTextWidget(title: 'Discount amount'),
                    CustomTextFieldWidget(
                      hintText: 'Discount amount',
                      fieldName: 'Discount amount',
                      controller: discountAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final double? parsed = double.tryParse(value);
                        if (parsed != null) {
                          context.read<EditPaymentCubit>().updateDiscountAmount(parsed);
                        }
                      },
                    ),
                    SizedBox(height: height * 0.15),
                    CustomGreenButtonWidget(
                      name: 'Save',
                      onPressed: () {
                        // Updates are already emitted on change; just pop back
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}