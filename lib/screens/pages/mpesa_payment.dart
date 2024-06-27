import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MPesaPaymentPage(),
    );
  }
}

class MPesaPaymentPage extends StatefulWidget {
  @override
  _MPesaPaymentPageState createState() => _MPesaPaymentPageState();
}

class _MPesaPaymentPageState extends State<MPesaPaymentPage> {
  final PaystackPlugin _paystackPlugin = PaystackPlugin();
  final TextEditingController _paymentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paystackPlugin.initialize(publicKey: 'pk_live_aa3b32698a54ea6baf8a78f748dd763a09f076d0'); // Kenya Paystack public key
  }

  void _handlePayment(BuildContext context, int amount) async {
    Charge charge = Charge()
      ..amount = amount * 100  // Amount in kobo (100 kobo = 1 KES)
      ..email = 'customer@example.com'
      ..currency = 'KES'  // or 'GHS' for Ghana
      ..reference = _getReference();

    CheckoutResponse response = await _paystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,  // Defaults to CheckoutMethod.selectable
      charge: charge,
    );

    if (response.status) {
      // Payment successful
      print('Payment successful: ${response.reference}');
    } else {
      // Payment failed
      print('Payment failed: ${response.message}');
    }
  }

  String _getReference() {
    return 'ChargedFromFlutter_${DateTime.now().millisecondsSinceEpoch}';
  }

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
            _buildPricingPlan('1. Family monthly plan', 10, context),
            _buildPricingPlan('2. Monthly yearly Plan', 50, context),
            _buildPricingPlan('3. Average monthly Plan', 100, context),
            _buildPricingPlan('4. Individual yearly Plan', 200, context),
            _buildPricingPlan('5. Individual monthly plan', 500, context),
            SizedBox(height: 32.0),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    'After payment kindly send a screenshot of your payment and student ID to sylvia.mwitumi@meltwater.org',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _paymentTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter text to send to M-Pesa',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Go to Login', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
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

  Widget _buildPricingPlan(String planName, int amount, BuildContext context) {
    return Column(
      children: [
        Text(
          '$planName: Send GHC $amount to +2335362323333',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () => _handlePayment(context, amount),
          child: Text('Pay GHC $amount with Paystack',
              style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
