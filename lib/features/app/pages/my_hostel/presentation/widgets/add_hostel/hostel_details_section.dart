import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_text_field_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/core/utils/validators.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/facility_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/hostel_form_controller.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/location_section.dart';

class HostelDetailsSection extends StatelessWidget {
  final HostelFormController formController;
  final VoidCallback onErrorChanged;

  const HostelDetailsSection({
    super.key,
    required this.formController,
    required this.onErrorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextWidget(title: 'Hostel Details'),
        SizedBox(height: padding),
        CustomTextFieldWidget(
          hintText: 'Name',
          fieldName: 'Name',
          controller: formController.nameController,
          errorText: formController.nameError,
          validator: Validation.validateName,
          onChanged: (_) {
            formController.clearNameError();
            onErrorChanged();
          },
        ),
        SizedBox(height: padding),
        CustomTextFieldWidget(
          hintText: 'Contact Number',
          fieldName: 'Contact Number',
          controller: formController.contactNumberController,
          errorText: formController.contactError,
          validator: Validation.validatePhone,
          keyboardType: TextInputType.phone,
          initialCountryCode: formController.countryCode ?? '+91',
          onCountryCodeChanged: (fullNumber) {
            formController.setCountryCode(fullNumber.substring(0, fullNumber.length - formController.contactNumberController.text.length));
            formController.clearContactError();
            onErrorChanged();
          },
          onChanged: (_) {
            formController.clearContactError();
            onErrorChanged();
          },
        ),
        SizedBox(height: padding),
        CustomTextFieldWidget(
          hintText: 'Description',
          fieldName: 'Description',
          expanded: true,
          controller: formController.descriptionController,
          errorText: formController.descriptionError,
          validator: Validation.validateDescription,
          onChanged: (_) {
            formController.clearDescriptionError();
            onErrorChanged();
          },
        ),
        SizedBox(height: padding),
        Text(
          'Add facilities',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        FacilitySection(
          facilityController: formController.facilityController,
          facilityError: formController.facilityError,
          facilities: formController.facilities,
          onAddFacility: formController.addFacility,
          onRemoveFacility: formController.removeFacility,
          onFacilityAdded: onErrorChanged,
        ),
        SizedBox(height: padding),
        LocationSection(locationError: formController.locationError),
      ],
    );
  }
}