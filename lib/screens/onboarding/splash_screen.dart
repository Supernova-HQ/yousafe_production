import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding screens after some delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboardingOne');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 12, 195), // Set the background color of the splash screen to purple
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Set the image width to 60% of the screen width
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 155, 12, 195), // Set the background color of the container to purple
          ),
          child: Image.asset('assets/clearlogo.png'), // Replace with your asset path
        ),
      ),
    );
  }
}
