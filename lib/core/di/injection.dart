import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in_package;
import 'package:packinh/core/services/local_storage_service.dart';
import 'package:packinh/features/app/pages/account/data/datasource/user_profile_remote_data_source.dart';
import 'package:packinh/features/app/pages/account/data/repository/user_profile_repository_impl.dart';
import 'package:packinh/features/app/pages/account/domain/repository/user_profile_repository.dart';
import 'package:packinh/features/app/pages/account/domain/usecases/get_user_use_case.dart';
import 'package:packinh/features/app/pages/account/domain/usecases/update_user_use_case.dart';
import 'package:packinh/features/app/pages/account/presentation/provider/bloc/profile/profile_bloc.dart';
import 'package:packinh/features/app/pages/chat/data/datasource/chat_remote_data_source.dart';
import 'package:packinh/features/app/pages/chat/data/datasource/owner_remote_data_source.dart';
import 'package:packinh/features/app/pages/chat/data/repository/chat_repository_impl.dart';
import 'package:packinh/features/app/pages/chat/data/repository/owner_repository_impl.dart';
import 'package:packinh/features/app/pages/chat/domain/repository/chat_repository.dart';
import 'package:packinh/features/app/pages/chat/domain/repository/owner_repository.dart';
import 'package:packinh/features/app/pages/chat/domain/usecases/create_chat_use_case.dart';
import 'package:packinh/features/app/pages/chat/domain/usecases/get_chats_use_case.dart';
import 'package:packinh/features/app/pages/chat/domain/usecases/get_messages_use_case.dart';
import 'package:packinh/features/app/pages/chat/domain/usecases/get_owner_details_use_case.dart';
import 'package:packinh/features/app/pages/chat/domain/usecases/send_message_use_case.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/review_remote_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/data/repository/review_repository_impl.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/review_repository.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/delete_hostel.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/get_review_use_case.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/review/review_bloc.dart';
import 'package:packinh/features/app/pages/wallet/data/datasources/rent_paid_remote_data_source.dart';
import 'package:packinh/features/app/pages/wallet/data/respository/payment_repository_impl.dart';
import 'package:packinh/features/app/pages/wallet/domain/respository/payment_repository.dart';
import 'package:packinh/features/app/pages/wallet/domain/usecases/get_rent_use_case.dart';
import 'package:packinh/features/app/pages/wallet/domain/usecases/rent_paid_use_case.dart';
import 'package:packinh/features/app/pages/wallet/domain/usecases/update_payment_use_case.dart';
import 'package:packinh/features/app/pages/wallet/presentation/provider/bloc/rent_bloc.dart';
import 'package:packinh/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:packinh/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:packinh/features/auth/data/repository/auth_repository_impl.dart';
import 'package:packinh/features/auth/domain/repository/auth_repository.dart';
import 'package:packinh/features/auth/domain/usecase/check_auth_status.dart';
import 'package:packinh/features/auth/domain/usecase/google_sign_in.dart'
    as google_sign_in_usecase;
import 'package:packinh/features/auth/domain/usecase/sign_in_with_email.dart';
import 'package:packinh/features/auth/domain/usecase/sign_out.dart';
import 'package:packinh/features/auth/domain/usecase/sign_up_with_email.dart';
import 'package:packinh/features/auth/domain/usecase/verify_otp.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/cloudinary_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/hostel_remote_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/data/repository/hostel_repository_impl.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/repository/hostel_repository.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/add_hostel.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/get_hostel_by_owner.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/usecases/update_hostel.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/add_hostel/add_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/update_hostel/update_hostel_bloc.dart';
import 'package:packinh/features/auth/domain/usecase/reset_password.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/email/email_auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/google/google_auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/bloc/otp/otp_auth_bloc.dart';
import 'package:packinh/features/auth/presentation/provider/cubit/otp_cubit.dart';
import 'package:packinh/features/auth/presentation/provider/cubit/sign_up_cubit.dart';
import '../../features/app/pages/account/presentation/provider/bloc/edit_profile/edit_profile_bloc.dart';
import '../../features/app/pages/bookings/data/datasourse/occupants_remote_data_source.dart';
import '../../features/app/pages/bookings/data/repository/occupant_repository_impl.dart';
import '../../features/app/pages/bookings/domain/repository/occupant_repository.dart';
import '../../features/app/pages/bookings/domain/usecases/get_occupant_by_hostel_id.dart';
import '../../features/app/pages/bookings/domain/usecases/get_occupant_by_id.dart';
import '../../features/app/pages/bookings/presentation/provider/bloc/occupant_details_bloc/occupant_details_bloc.dart';
import '../../features/app/pages/bookings/presentation/provider/bloc/occupants_bloc/occupants_bloc.dart';
import '../../features/app/pages/chat/presentation/providers/bloc/allchats/all_chat_bloc.dart';
import '../../features/app/pages/chat/presentation/providers/bloc/chat/chat_bloc.dart';
import '../../features/auth/domain/usecase/send-otp.dart';
import '../services/cloudinary_services.dart';
import '../services/image_picker_service.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // External Dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<google_sign_in_package.GoogleSignIn>(
    () => google_sign_in_package.GoogleSignIn(scopes: ['email', 'profile']),
  );

  // Services
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
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
  getIt.registerLazySingleton<OccupantsRemoteDataSource>(
    () => OccupantsRemoteDataSource(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<RentPaidRemoteDataSource>(
    () => RentPaidRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<OwnerRemoteDataSource>(
        () => OwnerRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<ReviewRemoteDataSource>(
        () => ReviewRemoteDataSourceImpl(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<UserProfileRemoteDataSource>(
        () => UserProfileRemoteDataSourceImpl(firestore: getIt<FirebaseFirestore>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<HostelRepository>(
    () => HostelRepositoryImpl(getIt<HostelRemoteDataSource>()),
  );
  getIt.registerLazySingleton<OccupantsRepository>(
    () => OccupantsRepositoryImpl(getIt<OccupantsRemoteDataSource>()),
  );

  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt<RentPaidRemoteDataSource>()),
  );

  getIt.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(getIt<ChatRemoteDataSource>()),
  );

  getIt.registerLazySingleton<OwnerRepository>(
        () => OwnerRepositoryImpl(getIt<OwnerRemoteDataSource>()),
  );

  getIt.registerLazySingleton<ReviewRepository>(
        () => ReviewRepositoryImpl(getIt<ReviewRemoteDataSource>()),
  );

  getIt.registerLazySingleton<UserProfileRepository>(
        () => UserProfileRepositoryImpl(remoteDataSource: getIt<UserProfileRemoteDataSource>()),
  );




  // Use Cases
  getIt.registerLazySingleton(() => CheckAuthStatus(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => google_sign_in_usecase.GoogleSignIn(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignInWithEmail(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpWithEmail(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignOut(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => VerifyOtp(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SendOtp(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => AddHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(
      () => GetHostelsByOwner(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => DeleteHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => ResetPassword(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => UpdateHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(
      () => GetOccupantsByHostelId(getIt<OccupantsRepository>()));
  getIt.registerLazySingleton(
    () => GetOccupantById(getIt<OccupantsRepository>()),
  );
  getIt.registerLazySingleton(
    () => RentPaidUseCase(getIt<PaymentRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetRentUseCase(getIt<PaymentRepository>()),
  );

  getIt.registerLazySingleton(
        () => UpdatePaymentUseCase(getIt<PaymentRepository>()),
  );

  getIt.registerLazySingleton(() => CreateChatUseCase(getIt<ChatRepository>()),);
  getIt.registerLazySingleton(() => GetChatsUseCase(getIt<ChatRepository>()),);
  getIt.registerLazySingleton(() => GetMessagesUseCase(getIt<ChatRepository>()),);
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt<ChatRepository>()),);
  getIt.registerLazySingleton(() => GetOwnerDetailsUseCase(getIt<OwnerRepository>()),);


  getIt.registerLazySingleton(() => GetReviewsUseCase(getIt<ReviewRepository>()),);


  getIt.registerLazySingleton(() => GetUserUseCase(getIt<UserProfileRepository>()),);
  getIt.registerLazySingleton(() => UpdateUserUseCase(getIt<UserProfileRepository>()),);





  // BLoCs
  getIt.registerFactory(
    () => EmailAuthBloc(
      signInWithEmail: getIt<SignInWithEmail>(),
      signUpWithEmail: getIt<SignUpWithEmail>(),
      resetPassword: getIt<ResetPassword>(),
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
    () => MyHostelsBloc(
        deleteHostel: getIt<DeleteHostel>(),
        getHostelsByOwner: getIt<GetHostelsByOwner>()),
  );
  getIt.registerFactory(
    () => UpdateHostelBloc(updateHostel: getIt<UpdateHostel>()),
  );
  getIt.registerFactory(
    () =>
        OccupantsBloc(getOccupantsByHostelId: getIt<GetOccupantsByHostelId>()),
  );
  getIt.registerFactory(
    () => OccupantDetailsBloc(getOccupantById: getIt<GetOccupantById>()),
  );
  getIt.registerFactory(
    () => RentBloc(
        getRentUseCase: getIt<GetRentUseCase>(),
        rentPaidUseCase: getIt<RentPaidUseCase>(),
      updatePaymentUseCase: getIt<UpdatePaymentUseCase>(),
    ),
  );
  getIt.registerFactory(() => AllChatBloc(getIt<GetChatsUseCase>()));
  getIt.registerFactoryParam<ChatBloc, String, void>(
        (chatId, _) => ChatBloc(
      getMessagesUseCase: getIt<GetMessagesUseCase>(),
      sendMessageUseCase: getIt<SendMessageUseCase>(),
      chatId: chatId,
    ),
  );

  getIt.registerFactory(() => ReviewBloc(getReviewsUseCase: getIt<GetReviewsUseCase>()));

  getIt.registerFactory(() => EditProfileBloc( updateUserUseCase: getIt<UpdateUserUseCase>()));
  getIt.registerFactory(() => ProfileBloc( getUserUseCase: getIt<GetUserUseCase>()));




  // Cubits
  getIt.registerFactory(() => OtpCubit());
  getIt.registerFactory(() => SignUpCubit());
}
