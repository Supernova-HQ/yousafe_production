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
      title: 'Subscription Plans',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SubscriptionPlansPage(),
    );
  }
}

class SubscriptionPlansPage extends StatefulWidget {
  @override
  _SubscriptionPlansPageState createState() => _SubscriptionPlansPageState();
}

class _SubscriptionPlansPageState extends State<SubscriptionPlansPage> {
  final PaystackPlugin _paystackPlugin = PaystackPlugin();
  final String publicKey = 'pk_live_aa3b32698a54ea6baf8a78f748dd763a09f076d0';

  @override
  void initState() {
    super.initState();
    _paystackPlugin.initialize(publicKey: publicKey);
  }

  void _subscribe(String planName, int amount) async {
    Charge charge = Charge()
      ..amount = amount * 100  // Amount in kobo (100 kobo = 1 KES)
      ..email = 'customer@example.com'
      ..currency = 'KES'  // or 'GHS' for Ghana
      ..reference = _getReference()
      ..plan = planName;

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
        title: Text('Subscription Plans'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPlanCard('Individual Monthly Plan', 'KES 640.00', 'PLN_h58iy9n4haqr7pi', 640),
            _buildPlanCard('Individual Yearly Plan', 'KES 7,680.00', 'PLN_gxgspy3sv08vd7x', 7680),
            _buildPlanCard('Average Individual Plan', 'KES 256.00', 'PLN_jliiutwl1j5hanf', 256),
            _buildPlanCard('Family Individual Plan', 'KES 1,000.00', 'PLN_uzjf8ngzhfrpae3', 1000),
            _buildPlanCard('Family Plan', 'KES 12,000.00', 'PLN_fhjlewwznm17att', 12000),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String planName, String amount, String planCode, int amountValue) {
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
              amount,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _subscribe(planCode, amountValue),
                child: Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
