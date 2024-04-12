import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TraumaBookingPage extends StatelessWidget {
  final String calendlyLink = 'https://calendly.com/shadrack-apollo/trauma-counselling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Trauma Therapy Session'),
        backgroundColor: Colors.white,
      ),
      body: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: Uri.encodeFull(calendlyLink),
        ),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          // Customize the web view if needed
        },
      ),
    );
  }
}