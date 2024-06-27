import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _subscribe(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
            _buildPlanCard('Individual Plan (Monthly Subscription)', 'KES 640.00/Month', 'https://paystack.com/pay/8i851orhuo'),
            _buildPlanCard('Individual Plan (Yearly Subscription)', 'KES 7,680.00/Annum', 'https://paystack.com/pay/8reh762sd6'),
            _buildPlanCard('Student Plan', 'KES 256.00/Month', 'https://paystack.com/pay/capse--g8p'),
            _buildPlanCard('Family Plan (Monthly Subscription)', 'KES 1,000.00/ per family per year', 'https://paystack.com/pay/h2j033u3fd'),
            _buildPlanCard('Family Plan (Yearly Subscription)', 'KES 12,000.00/ per family per year', 'https://paystack.com/pay/r2nv3vwk-s'),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(String planName, String amount, String url) {
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
                onPressed: () => _subscribe(url),
                child: Text('Subscribe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
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
