import 'package:flutter/material.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String _selectedSubscription = 'Annual - 2 Months free';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Try YouSafe Premium'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildFeatureItem(
            //   Icons.health_and_safety,
            //   'Get 24/7 Support from our team of experts and an instant callback whenever you request help',
            // ),
            // _buildFeatureItem(
            //   Icons.playlist_add_check,
            //   'Access trauma counselling and self defense education right in the app to ensure you feel safe',
            // ),
            // _buildFeatureItem(
            //   Icons.insights,
            //   'Get insights into crime and safety reports in your area so you can protect yourself ahead of time',
            // ),
            SizedBox(height: 24),
            Text(
              'Payments are collected securely by Paystack; ensure you use the same email address you used to sign up for YouSafe to avoid any issues with your subscription. Thank you',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            
            Text(
              'Terms of Service & Privacy Policy',
              style: TextStyle(
                color: Colors.purple,
                decoration: TextDecoration.underline,
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/subscription');
                  // Handle subscribe button press
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Proceed to See Plans',
                      style: TextStyle(color: Colors.white)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(width: 16),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOption(
    String title,
    String subtitle,
    String badge,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(subtitle),
              ],
            ),
          ),
          if (badge.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badge,
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
