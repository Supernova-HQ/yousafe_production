import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouSafe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<String?>(
              future: getAccessToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.hasData) {
                    // Access token exists, navigate to the homepage or emergency contacts page
                    return HomePage();
                  } else {
                    // No access token found, navigate to the splash screen
                    return SplashScreen();
                  }
                }
              },
            ),
        '/splash': (context) => SplashScreen(),
        '/onboardingOne': (context) => OnboardingOne(),
        '/onboardingTwo': (context) => OnboardingTwo(),
        '/onboardingThree': (context) => OnboardingThree(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/verify': (context) => VerifyScreen(),
        '/homepage': (context) => HomePage(),
        '/sos': (context) => SOSRequestWidget(),
        '/contacts': (context) => EmergencyContactsPage(),
        '/payments': (context) => PaymentsPage(),
        // '/mpesa': (context) => MPesaPaymentPage(),
      },
    );
  }
}