import 'package:flutter/material.dart';
import 'package:pdf_generator/page/login_page.dart';
import 'package:pdf_generator/page/onboarding_page.dart';
import 'package:pdf_generator/page/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final showLoginPage = prefs.getBool('showLoginPage') ?? false;


  runApp(MyApp(showLoginPage: showLoginPage));
}

class MyApp extends StatelessWidget {
  final bool showLoginPage;
  const MyApp({
    Key? key,
    required this.showLoginPage}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showLoginPage ? LoginPage() : OnboardingPage(),
    );
  }
}
