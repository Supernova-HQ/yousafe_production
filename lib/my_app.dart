import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/home_page.dart';
import 'package:yousafe/screens/pages/mpesa_payment.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/onboarding/onboarding_one.dart';
import 'screens/onboarding/onboarding_two.dart';
import 'screens/onboarding/onboarding_three.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/verify_screen.dart';
import 'screens/pages/sos_request.dart';
import 'screens/pages/emergency_contacts_page.dart';
import 'screens/pages/payments_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouSafe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // Define the initial route
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboardingOne': (context) => OnboardingOne(),
        '/onboardingTwo': (context) => OnboardingTwo(),
        '/onboardingThree': (context) => OnboardingThree(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/verify': (context) => VerifyScreen(),
        '/homepage':(context) => HomePage(),
        '/sos' :(context) => SOSRequestWidget(),
        '/contacts' :(context) => EmergencyContactsPage(),
        '/payments' :(context) => PaymentsPage(),
        '/mpesa' :(context) => MPesaPaymentPage(),
      },
    );
  }
}
