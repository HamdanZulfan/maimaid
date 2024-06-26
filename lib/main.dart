import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maimaid_app/blocs/user_bloc/user_bloc.dart';
import 'package:maimaid_app/screen/create_user_screen.dart';
import 'package:maimaid_app/screen/home_screen.dart';
import 'package:maimaid_app/screen/onboarding_screen.dart';
import 'package:maimaid_app/screen/splash_screen.dart';
import 'package:maimaid_app/services/api_service.dart';
import 'package:maimaid_app/widgets/success_delete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Splash Auto Play',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => OnboardingScreen(),
          '/home': (context) => const HomeScreen(),
          '/createUser': (context) => const CreateUserScreen(),
          '/successDelete': (context) => const SuccessDelete(),
        },
      ),
    );
  }
}
