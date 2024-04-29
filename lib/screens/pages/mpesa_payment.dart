import 'package:flutter/material.dart';

class MPesaPaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'For payment kindly use the below MOMO number to make payments. Choose one option',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Send GHC 10 to +2335362323333 to pay for student plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Send GHC 50 to +2335362323333 to pay for Individual plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'After payment kindly send a screenshot of your payment and student ID to sylvia.mwitumi@meltwater.org',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                 Navigator.pushReplacementNamed(context, '/login');
                // Handle "Go to Login" button press
              },
              child: Text('Go to Login',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}