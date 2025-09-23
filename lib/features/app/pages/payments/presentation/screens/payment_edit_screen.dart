import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/services/date_picker.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';
import 'package:packinh/core/widgets/custom_text_field_widget.dart';
import '../../data/model/payment_model.dart';
import '../provider/bloc/rent_bloc.dart';

class PaymentEditScreen extends StatefulWidget {
  PaymentEditScreen({super.key, required this.payments});

  final PaymentModel payments;

  @override
  State<PaymentEditScreen> createState() => _PaymentEditScreenState();
}

class _PaymentEditScreenState extends State<PaymentEditScreen> {
  late TextEditingController dueDateController;
  late TextEditingController rentController;
  late TextEditingController additionalMessageController;
  late TextEditingController additionalAmountController;
  late TextEditingController discountAmountController;

  @override
  void initState() {
    super.initState();

    dueDateController = TextEditingController(
        text: widget.payments.dueDate.toString().substring(0, 10));
    rentController =
        TextEditingController(text: widget.payments.rent.toString());
    additionalMessageController =
        TextEditingController(text: widget.payments.extraMessage ?? '');
    additionalAmountController = TextEditingController(
        text: widget.payments.extraAmount?.toString() ?? '');
    discountAmountController =
        TextEditingController(text: widget.payments.discount?.toString() ?? '');
  }

  @override
  void dispose() {
    dueDateController.dispose();
    rentController.dispose();
    additionalAmountController.dispose();
    additionalMessageController.dispose();
    discountAmountController.dispose();
    super.dispose();
  }

  void _savePayment() {
    final Map<String, dynamic> updatedData = {};

    // Compare and add only changed fields
    final newDueDate = DateTime.tryParse(dueDateController.text);
    if (newDueDate != null && newDueDate != widget.payments.dueDate) {
      updatedData['dueDate'] = Timestamp.fromDate(newDueDate);
    }

    final newRent = double.tryParse(rentController.text);
    if (newRent != null && newRent != widget.payments.rent) {
      updatedData['rent'] = newRent;
    }

    final newExtraMessage = additionalMessageController.text.isNotEmpty
        ? additionalMessageController.text
        : null;
    if (newExtraMessage != widget.payments.extraMessage) {
      updatedData['extraMessage'] = newExtraMessage;
    }

    final newExtraAmount = double.tryParse(additionalAmountController.text);
    if (newExtraAmount != widget.payments.extraAmount) {
      updatedData['extraAmount'] = newExtraAmount;
    }

    final newDiscount = double.tryParse(discountAmountController.text);
    if (newDiscount != widget.payments.discount) {
      updatedData['discount'] = newDiscount;
    }

    // Only dispatch the event if there are changes
    if (updatedData.isNotEmpty) {
      context.read<RentBloc>().add(UpdatePaymentEvent(
            id: widget.payments.id!,
            data: updatedData,
          ));
    }

    // Navigate back after saving
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RentBloc, RentState>(
      listener: (context, state) {
        if (state is RentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(text: state.message),
          );
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, height * 0.18),
            child: CustomAppBarWidget(title: 'Edit payment')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(padding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height50,
                      GestureDetector(
                        onTap: () async {
                          final date = await datePicker(context);
                          if (date != null) {
                            dueDateController.text =
                                date.toString().substring(0, 10);
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFieldWidget(
                            hintText: 'Due date',
                            fieldName: 'Due date',
                            controller: dueDateController,
                          ),
                        ),
                      ),
                      height10,
                      CustomTextFieldWidget(
                        hintText: 'Rent',
                        fieldName: 'Rent',
                        controller: rentController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                      height10,
                      CustomTextFieldWidget(
                        hintText: 'Add additional message',
                        fieldName: 'Additional message',
                        controller: additionalMessageController,
                        onChanged: (value) {},
                      ),
                      height10,
                      CustomTextFieldWidget(
                        hintText: 'Add additional amount',
                        fieldName: 'Additional amount',
                        controller: additionalAmountController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                      height10,
                      CustomTextFieldWidget(
                        hintText: 'Discount amount',
                        fieldName: 'Discount amount',
                        controller: discountAmountController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                      height50,
                      CustomGreenButtonWidget(
                        name: 'Save',
                        onPressed: _savePayment,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
