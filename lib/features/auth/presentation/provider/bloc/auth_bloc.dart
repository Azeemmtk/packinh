import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/current_user.dart';
import '../../../../../core/services/local_storage_service.dart';
import '../../../domain/usecase/check_auth_status.dart';
import '../../../domain/usecase/sign_out.dart';
import 'email/email_auth_bloc.dart';
import 'email/email_auth_state.dart';
import 'google/google_auth_bloc.dart';
import 'otp/otp_auth_bloc.dart';

class AuthBloc extends Bloc<dynamic, dynamic> {
  final CheckAuthStatus checkAuthStatus;
  final SignOut signOut;
  final EmailAuthBloc emailAuthBloc;
  final GoogleAuthBloc googleAuthBloc;
  final OtpAuthBloc otpAuthBloc;
  final LocalStorageService localStorageService;

  AuthBloc({
    required this.checkAuthStatus,
    required this.signOut,
    required this.emailAuthBloc,
    required this.googleAuthBloc,
    required this.otpAuthBloc,
    required this.localStorageService
  }) : super(null) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<dynamic> emit) async {
    emit(const EmailAuthLoading());
    final result = await checkAuthStatus();
    result.fold(
          (failure) => emit(EmailAuthError(message: failure.message)),
          (user) async {
        if (user != null) {

          emit(EmailAuthAuthenticated(user: user));
          CurrentUser().name = user.name;
          CurrentUser().uId = user.uid;
          await localStorageService.saveUserId(user.uid); // Ensure it's saved
        } else {
          emit(const EmailAuthInitial());
        }
      },
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<dynamic> emit) async {
    emit(const EmailAuthLoading());
    final result = await signOut();
    result.fold(
          (failure) => emit(EmailAuthError(message: failure.message)),
          (_) async {
        CurrentUser().uId = null; // Clear CurrentUser on sign out
        emit(const EmailAuthInitial());
        await localStorageService.clearUserId();
      },
    );
  }
}

class CheckAuthStatusEvent {}

class SignOutEvent {}