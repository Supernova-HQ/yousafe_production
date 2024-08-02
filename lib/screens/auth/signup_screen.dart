import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yousafe/screens/auth/login_screen.dart';
import 'package:yousafe/screens/pages/home_page.dart';
import 'package:yousafe/screens/pages/payments_page.dart';
import 'package:yousafe/services/AuthService.dart';

class SignupScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> _handleGoogleSignUp(BuildContext context) async {
    try {
      final User? user = await _authService.signInWithGoogle();
      if (user != null) {
        // Check if the user is new or existing
        if (user.metadata.creationTime == user.metadata.lastSignInTime) {
          // New user, navigate to the payments page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PaymentsPage()),
          );
        } else {
          // Existing user, navigate to the home page
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } else {
        throw Exception('Failed to sign in with Google');
      }
    } catch (error) {
      print('Google sign-up error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-up failed: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Colors.purple,
                child: Center(
                  child: Image.asset(
                    'assets/clearlogo.png',
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Join YouSafe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sign up now to start protecting yourself and your loved ones.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () => _handleGoogleSignUp(context),
                    icon: Icon(Icons.g_mobiledata, color: Colors.white),
                    label: Text(
                      'Sign up with Google',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WaveClipper class remains unchanged

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:yousafe/screens/auth/login_screen.dart';
// import 'package:yousafe/screens/pages/home_page.dart';
// import 'package:yousafe/screens/pages/payments_page.dart';
// import 'package:yousafe/services/AuthService.dart';

// class SignupScreen extends StatelessWidget {

//   final AuthService _authService = AuthService();

//   Future<void> _handleGoogleSignUp(BuildContext context) async {
//     try {
//       final userCredential = await _authService.signInWithGoogle();
//       if (userCredential != null) {
//         // Navigate to the payments page after successful Google sign-up
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => PaymentsPage()),
//         );
//       }
//     } catch (error) {
//       print('Google sign-up error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google sign-up failed. Please try again.')),
//       );
//     }
//   }
//   // final GoogleSignIn _googleSignIn = GoogleSignIn();

//   // Future<void> _handleGoogleSignUp(BuildContext context) async {
//   //   try {
//   //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//   //     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//   //     // TODO: Implement Google sign-up logic using the googleAuth object

//   //     // Navigate to the payments page after successful Google sign-up
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => PaymentsPage()),
//   //     );
//   //   } catch (error) {
//   //     print('Google sign-up error: $error');
//   //     // Handle Google sign-up error
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Google sign-up failed. Please try again.')),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 height: 250,
//                 color: Colors.purple,
//                 child: Center(
//                   child: Image.asset(
//                     'assets/clearlogo.png',
//                     height: 200,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.white,
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: OutlinedButton.icon(
//                       onPressed: () => _handleGoogleSignUp(context),
//                       icon: Icon(Icons.g_mobiledata, color: Colors.purple),
//                       label: Text(
//                         'Sign up with Google',
//                         style: TextStyle(color: Colors.purple),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: Colors.purple),
//                         padding: EdgeInsets.all(16.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text('Already have an account?'),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => HomePage()),
//                           );
//                         },
//                         child: const Text('Login'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height);
//     var firstControlPoint = Offset(size.width / 4, size.height - 50);
//     var firstEndPoint = Offset(size.width / 2, size.height - 20);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//     var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
//     var secondEndPoint = Offset(size.width, size.height - 70);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }