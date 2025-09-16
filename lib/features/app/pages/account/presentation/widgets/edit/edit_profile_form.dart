import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';
import 'package:packinh/features/app/pages/account/presentation/widgets/edit/save_changes_button.dart';

import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/services/image_picker_service.dart';
import '../../../../../../../core/widgets/custom_text_field_widget.dart';
import '../../../../../../auth/data/model/user_model.dart';
import 'edit_profile_section.dart';

class EditProfileForm extends StatefulWidget {
  final UserModel user;

  const EditProfileForm({super.key, required this.user});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName ?? '');
    _emailController = TextEditingController(text: widget.user.email ?? '');
    _phoneController = TextEditingController(text: widget.user.phone ?? '');
    _ageController = TextEditingController(text: widget.user.age?.toString() ?? '');
    _addressController = TextEditingController(text: widget.user.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    try {
      final imagePicker = GetIt.instance<ImagePickerService>();
      final images = await imagePicker.showImageSourceDialog(context);
      if (images != null && images.isNotEmpty) {
        setState(() {
          _selectedImage = images[0];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: 'Error picking image: $e', color: Colors.red)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ProfileImageSection(
            user: widget.user,
            selectedImage: _selectedImage,
            onPickImage: _pickAndUploadImage,
          ),
          SizedBox(height: height * 0.02),
          CustomTextFieldWidget(
            hintText: 'Enter name',
            fieldName: 'Name',
            controller: _nameController,
            validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
          ),
          SizedBox(height: height * 0.02),
          CustomTextFieldWidget(
            hintText: 'Enter email',
            fieldName: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.02),
          CustomTextFieldWidget(
            hintText: 'Enter phone',
            fieldName: 'Phone',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final phone = value.replaceAll(RegExp(r'\D'), '');
                if (phone.length < 10) return 'Enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.02),
          CustomTextFieldWidget(
            hintText: 'Enter age',
            fieldName: 'Age',
            controller: _ageController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final age = int.tryParse(value);
                if (age == null || age < 0 || age > 150) return 'Enter a valid age';
              }
              return null;
            },
          ),
          SizedBox(height: height * 0.02),
          CustomTextFieldWidget(
            hintText: 'Enter address',
            fieldName: 'Address',
            controller: _addressController,
            expanded: true,
          ),
          SizedBox(height: height * 0.02),
          SaveChangesButton(
            formKey: _formKey,
            selectedImage: _selectedImage,
            user: widget.user,
            nameController: _nameController,
            emailController: _emailController,
            phoneController: _phoneController,
            ageController: _ageController,
            addressController: _addressController,
          ),
        ],
      ),
    );
  }
}
