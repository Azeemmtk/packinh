import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/custom_text_field_widget.dart';
import 'package:packinh/features/auth/presentation/screens/sign_in_screen.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _newPasswordController= TextEditingController();
    final TextEditingController _confirmPasswordController= TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.3),
                  Text(
                    'Setup new password',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Please, setup a new password for your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                  SizedBox(height: height * 0.02),
                CustomTextFieldWidget(
                  text: 'New Password',
                  isSecure: true,
                  controller: _newPasswordController,
                ),
                  SizedBox(height: height * 0.01),
                  CustomTextFieldWidget(
                    controller: _confirmPasswordController,
                    text: 'Repeat Password',
                    isSecure: true,
                  ),
                  const Spacer(),
                  CustomGreenButtonWidget(
                    name: 'Goto Sign in',
                    onPressed: () {

                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignInScreen()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: width * 0.045),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}