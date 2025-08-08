import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/theme/app_theme.dart';
import 'package:packinh/features/auth/presentation/provider/cubit/sign_in_cubit.dart';
import 'package:packinh/features/auth/presentation/provider/cubit/sign_up_cubit.dart';
import 'package:packinh/features/auth/presentation/screens/splash_screen.dart';
import 'core/constants/const.dart';
import 'core/services/current_user.dart';
import 'features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'features/auth/presentation/provider/bloc/auth_bloc.dart';
import 'features/auth/presentation/provider/bloc/email/email_auth_bloc.dart';
import 'features/auth/presentation/provider/bloc/google/google_auth_bloc.dart';
import 'features/auth/presentation/provider/bloc/otp/otp_auth_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Initialize Dependencies
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getSize(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<EmailAuthBloc>()),
        BlocProvider(create: (context) => getIt<GoogleAuthBloc>()),
        BlocProvider(create: (context) => getIt<OtpAuthBloc>()),
        BlocProvider(create: (context) => getIt<SignUpCubit>(),),
        BlocProvider(create: (context) => getIt<SignInCubit>(),),
        BlocProvider(create: (context) => getIt<MyHostelsBloc>()..add(FetchMyHostels(CurrentUser().uId ?? '')),)
      ],
      child: MaterialApp(
        title: 'packInh',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
