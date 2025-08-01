import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in_package;
import 'package:packinh/core/services/local_storage_service.dart';
import 'package:packinh/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:packinh/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:packinh/features/auth/data/repository/auth_repository_impl.dart';
import 'package:packinh/features/auth/domain/repository/auth_repository.dart';
import 'package:packinh/features/auth/domain/usecase/check_auth_status.dart';
import 'package:packinh/features/auth/domain/usecase/google_sign_in.dart' as google_sign_in_usecase;
import 'package:packinh/features/auth/domain/usecase/send-otp.dart';
import 'package:packinh/features/auth/domain/usecase/sign_in_with_email.dart';
import 'package:packinh/features/auth/domain/usecase/sign_out.dart';
import 'package:packinh/features/auth/domain/usecase/sign_up_with_email.dart';
import 'package:packinh/features/auth/domain/usecase/verify_otp.dart';
import '../../features/app/pages/my_hostel/data/dataSourse/cloudinary_data_source.dart';
import '../../features/app/pages/my_hostel/data/dataSourse/hostel_remote_data_source.dart';
import '../../features/app/pages/my_hostel/data/repository/hostel_repository_impl.dart';
import '../../features/app/pages/my_hostel/domain/repository/hostel_repository.dart';
import '../../features/app/pages/my_hostel/domain/usecases/add_hostel.dart';
import '../../features/app/pages/my_hostel/domain/usecases/get_hostel_by_owner.dart';
import '../../features/app/pages/my_hostel/presentation/provider/bloc/add_hostel/add_hostel_bloc.dart';
import '../../features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../../features/auth/presentation/provider/bloc/auth_bloc.dart';
import '../../features/auth/presentation/provider/bloc/email/email_auth_bloc.dart';
import '../../features/auth/presentation/provider/bloc/google/google_auth_bloc.dart';
import '../../features/auth/presentation/provider/bloc/otp/otp_auth_bloc.dart';
import '../../features/auth/presentation/provider/cubit/otp_cubit.dart';
import '../services/cloudinary_services.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // External Dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<google_sign_in_package.GoogleSignIn>(
        () => google_sign_in_package.GoogleSignIn(scopes: ['email', 'profile']),
  );

  // Services
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());

  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<google_sign_in_package.GoogleSignIn>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<CloudinaryDataSource>(
        () => CloudinaryDataSourceImpl(getIt<CloudinaryService>()),
  );
  getIt.registerLazySingleton<HostelRemoteDataSource>(
        () => HostelRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<HostelRepository>(
        () => HostelRepositoryImpl(getIt<HostelRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => CheckAuthStatus(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => google_sign_in_usecase.GoogleSignIn(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignInWithEmail(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpWithEmail(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignOut(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => VerifyOtp(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SendOtp(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => AddHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => GetHostelsByOwner(getIt<HostelRepository>()));

  // BLoCs
  getIt.registerFactory(
        () => EmailAuthBloc(
      signInWithEmail: getIt<SignInWithEmail>(),
      signUpWithEmail: getIt<SignUpWithEmail>(),
      localStorageService: getIt<LocalStorageService>(),
    ),
  );
  getIt.registerFactory(
        () => GoogleAuthBloc(
      googleSignIn: getIt<google_sign_in_usecase.GoogleSignIn>(),
      localStorageService: getIt<LocalStorageService>(),
    ),
  );
  getIt.registerFactory(
        () => OtpAuthBloc(
      sendOtp: getIt<SendOtp>(),
      verifyOtp: getIt<VerifyOtp>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerFactory(
        () => AuthBloc(
      checkAuthStatus: getIt<CheckAuthStatus>(),
      signOut: getIt<SignOut>(),
      emailAuthBloc: getIt<EmailAuthBloc>(),
      googleAuthBloc: getIt<GoogleAuthBloc>(),
      otpAuthBloc: getIt<OtpAuthBloc>(),
      localStorageService: getIt<LocalStorageService>(),
    ),
  );
  getIt.registerFactory(
        () => AddHostelBloc(addHostel: getIt<AddHostel>()),
  );
  getIt.registerFactory(
        () => MyHostelsBloc(getHostelsByOwner: getIt<GetHostelsByOwner>()),
  );

  // Cubits
  getIt.registerFactory(() => OtpCubit());
}