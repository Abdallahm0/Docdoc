import 'package:docdoc/presentation/screens/main_screen.dart';
import 'package:docdoc/presentation/screens/registration_screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'core/helpers/dio_helper.dart';
import 'core/helpers/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init(baseUrl: 'https://vcare.integration25.com/api');
  final rememberMe = await SharedPrefsHelper().getRememberMe();
  final token = await SharedPrefsHelper().getRegistrationToken();

  runApp(
    MyApp(
        initialRoute: (token != null && token.isNotEmpty && rememberMe)
            ? '/main'
            : '/signIn'),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DocDoc',
      initialRoute: initialRoute,
      routes: {
        '/signIn': (_) => const SignInScreen(),
        '/main': (_) => const MainScreen(),
      },
    );
  }
}