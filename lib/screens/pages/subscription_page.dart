import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:uuid/uuid.dart';

class SubscriptionPlansPage extends StatefulWidget {
  @override
  _SubscriptionPlansPageState createState() => _SubscriptionPlansPageState();
}

class _SubscriptionPlansPageState extends State<SubscriptionPlansPage> {
  final String secretKey = 'your_secret_key_here';
  final String customerEmail = 'info@yousafeapp.com';
  final Uuid _uuid = Uuid();

  void _initiatePayment(BuildContext context, String planName, double amount) {
    final String uniqueTransRef = _uuid.v4();

    PayWithPayStack().now(
      context: context,
      secretKey: secretKey,
      customerEmail: customerEmail,
      reference: uniqueTransRef,
      callbackUrl: "/homepage",
      currency: "KES",
      paymentChannel: ["mobile_money", "card"],
      amount: amount,
      transactionCompleted: () {
        print("Transaction Successful for $planName");
        // Handle successful transaction (e.g., update user's subscription status)
      },
      transactionNotCompleted: () {
        print("Transaction Not Successful for $planName");
        // Handle failed transaction
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Plans'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPlanCard(context, 'Individual Plan (Monthly)', 'KES 640.00/Month', 64000),
            _buildPlanCard(context, 'Individual Plan (Yearly)', 'KES 7,680.00/Annum', 768000),
            _buildPlanCard(context, 'Student Plan', 'KES 256.00/Month', 25600),
            _buildPlanCard(context, 'Family Plan (Monthly)', 'KES 1,000.00/Month', 100000),
            _buildPlanCard(context, 'Family Plan (Yearly)', 'KES 12,000.00/Year', 1200000),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String planName, String displayAmount, double amount) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              displayAmount,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _initiatePayment(context, planName, amount),
                child: Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
}