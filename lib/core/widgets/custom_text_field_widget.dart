import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart'; // Import the package
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.hintText,
    required this.fieldName,
    this.isSecure = false,
    this.errorText,
    this.onChanged,
    this.expanded = false,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.onCountryCodeChanged,
    this.initialCountryCode = 'IN',
  });

  final String hintText;
  final String fieldName;
  final bool isSecure;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool expanded;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onCountryCodeChanged; // Callback for country code
  final String initialCountryCode; // Initial country code

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late bool secure = widget.isSecure;
  String? selectedCountryCode; // Store selected country code

  @override
  void initState() {
    super.initState();
    selectedCountryCode = widget.initialCountryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        height5,
        TextFormField(
          controller: widget.controller,
          obscureText: secure,
          minLines: widget.expanded ? 4 : 1,
          maxLines: widget.expanded ? 4 : 1,
          onChanged: (value) {
            widget.onChanged?.call(value);
            // Optionally combine country code with phone number
            if (widget.onCountryCodeChanged != null && selectedCountryCode != null) {
              widget.onCountryCodeChanged!('$selectedCountryCode$value');
            }
          },
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            filled: true,
            prefixIcon: widget.keyboardType == TextInputType.phone
                ? CountryCodePicker(
              onChanged: (countryCode) {
                setState(() {
                  selectedCountryCode = countryCode.dialCode;
                });
                widget.onCountryCodeChanged?.call('$selectedCountryCode${widget.controller.text}');
              },
              initialSelection: widget.initialCountryCode,
              favorite: const ['+1', 'US', '+91', 'IN'], // Favorite country codes
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
              textStyle: const TextStyle(color: Colors.black),
            )
                : null,
            suffixIcon: widget.isSecure
                ? IconButton(
              onPressed: () {
                setState(() {
                  secure = !secure;
                });
              },
              icon: secure
                  ? Icon(
                CupertinoIcons.eye_slash,
                size: width * 0.06,
                color: customGrey,
              )
                  : Icon(
                CupertinoIcons.eye,
                size: width * 0.06,
                color: customGrey,
              ),
            )
                : null,
            fillColor: textFieldColor,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainColor),
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
          ),
        ),
      ],
    );
  }
}