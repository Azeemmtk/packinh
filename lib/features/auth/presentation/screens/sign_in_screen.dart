import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';
import 'package:packinh/features/app/Navigation/presentation/screen/main_screen.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/email/email_auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/email/email_auth_event.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/email/email_auth_state.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/google/google_auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/google/google_auth_state.dart';
import 'package:packinh/features/auth/presentation/provider/cubit/sign_in_cubit.dart';
import 'package:packinh/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/features/auth/presentation/widgets/curved_container_widget.dart';
import 'package:packinh/features/auth/presentation/widgets/custom_auth_input_widget.dart';
import 'package:packinh/features/auth/presentation/widgets/google_sign_in_button_widget.dart';
import 'package:packinh/features/auth/presentation/widgets/remember_forgot_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, this.fromSignUp = false});
  final bool fromSignUp;

  @override
  Widget build(BuildContext context) {
    // Reset EmailAuthBloc state to initial when entering SignInScreen
    context.read<EmailAuthBloc>().add(const EmailAuthReset());

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmailAuthBloc, EmailAuthState>(
            listener: (context, state) {
              print('SignInScreen EmailAuthBloc received state: $state');
              if (state is EmailAuthAuthenticated && context.read<SignInCubit>().state.isSubmitting) {
                print('Navigating to MainScreen');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                      (route) => false,
                );
                if (fromSignUp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(text: 'Signed up successfully! You are now logged in.')
                  );
                }
                context.read<SignInCubit>().setSubmitting(false);
              } else if (state is EmailAuthError) {
                context.read<SignInCubit>().setSubmitting(false);
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(text: state.message,)
                );
              }
            },
          ),
          BlocListener<GoogleAuthBloc, GoogleAuthState>(
            listener: (context, state) {
              print('SignInScreen GoogleAuthBloc received state: $state');
              if (state is GoogleAuthAuthenticated) {
                print('Navigating to MainScreen');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                      (route) => false,
                );
              } else if (state is GoogleAuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(text: state.message,)
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurvedContainerWidget(height: 400, title: 'Sign In'),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocBuilder<SignInCubit, SignInState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomAuthInputWidget(
                          title: 'Email',
                          hint: 'demo@gmail.com',
                          icon: CupertinoIcons.mail,
                          errorText: state.emailError,
                          onChanged: (value) => context.read<SignInCubit>().updateEmail(value),
                        ),
                        height10,
                        CustomAuthInputWidget(
                          title: 'Password',
                          hint: 'Enter password',
                          isSecure: true,
                          icon: CupertinoIcons.lock,
                          errorText: state.passwordError,
                          onChanged: (value) => context.read<SignInCubit>().updatePassword(value),
                        ),
                        const RememberForgotWidget(),
                        height10,
                        CustomGreenButtonWidget(
                          name: 'Login',
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                            final formData = context.read<SignInCubit>().submitForm();
                            if (formData != null) {
                              context.read<SignInCubit>().setSubmitting(true);
                              context.read<EmailAuthBloc>().add(
                                EmailAuthSignIn(
                                  email: formData['email']!,
                                  password: formData['password']!,
                                ),
                              );
                            }
                          },
                          isLoading: state.isSubmitting,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ? ',
                              style: TextStyle(fontSize: width * 0.042),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: width * 0.042,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        height20,
                        height20,
                        GoogleSignInButtonWidget(
                          isLoading: context.watch<GoogleAuthBloc>().state is GoogleAuthLoading,
                          child: context.watch<GoogleAuthBloc>().state is GoogleAuthLoading
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : null,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}