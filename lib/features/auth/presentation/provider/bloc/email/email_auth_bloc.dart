import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/services/current_user.dart';
import '../../../../../../core/services/local_storage_service.dart';
import '../../../../domain/usecase/sign_in_with_email.dart';
import '../../../../domain/usecase/sign_up_with_email.dart';
import 'email_auth_event.dart';
import 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final LocalStorageService localStorageService;

  EmailAuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.localStorageService
  }) : super(const EmailAuthInitial()) {
    on<EmailAuthSignIn>(_onSignInWithEmail);
    on<EmailAuthSignUp>(_onSignUpWithEmail);
    on<EmailAuthSendPasswordReset>(_onSendPasswordReset);
  }

  Future<void> _onSignInWithEmail(
      EmailAuthSignIn event, Emitter<EmailAuthState> emit) async {
    emit(const EmailAuthLoading());
    final result = await signInWithEmail(
        SignInParams(email: event.email, password: event.password));
    result.fold(
          (failure) => emit(EmailAuthError(message: failure.message)),
          (user) async {
        print('Email sign-in success ${user.email}');
        CurrentUser().uId = user.uid;
        CurrentUser().name = user.name;
        emit(EmailAuthAuthenticated(user: user));
        await localStorageService.saveUserId(user.uid);
      },
    );
  }

  Future<void> _onSignUpWithEmail(
      EmailAuthSignUp event, Emitter<EmailAuthState> emit) async {
    emit(const EmailAuthLoading());
    final result = await signUpWithEmail(SignUpParams(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
    ));
    result.fold(
          (failure) => emit(EmailAuthError(message: failure.message)),
          (user) {
        print('Email signup successful for user: ${user.email}');
        emit(EmailAuthAuthenticated(user: user));
      },
    );
  }

  Future<void> _onSendPasswordReset(
      EmailAuthSendPasswordReset event, Emitter<EmailAuthState> emit) async {
    emit(const EmailAuthLoading());
    // Assuming a use case for sending password reset email exists
    // Implement password reset logic here
    emit(EmailAuthPasswordResetSent(email: event.email));
  }
}