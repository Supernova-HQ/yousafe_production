import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SOSRequestWidget extends StatefulWidget {
  @override
  _SOSRequestWidgetState createState() => _SOSRequestWidgetState();
}

class _SOSRequestWidgetState extends State<SOSRequestWidget> {
  String _status = 'Calling for Help...';
  bool _success = false;

  @override
  void initState() {
    super.initState();
    _startSOSProcess();
  }

  Future<void> _startSOSProcess() async {
    // Simulate calling for help
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _status = 'Reaching out to your emergency contacts';
    });

    // Simulate reaching out to emergency contacts
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _status = 'Sending your location to emergency contacts';
    });

    // Simulate sending location via SMS
    await Future.delayed(Duration(seconds: 2));

    // After completing the SOS process, wait for 4 seconds before displaying success message
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      _status = 'Your location has been sent out to all contacts';
      _success = true;
    });

    // Wait for 4 seconds before exiting
    await Future.delayed(Duration(seconds: 4));

    // Pop the screen after 4 seconds
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent the screen from being popped by the user
      child: Scaffold(
        appBar: AppBar(
          title: Text('SOS Request'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_success)
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 80,
                ),
              if (!_success)
                Lottie.asset(
                  'assets/help_is_coming.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              SizedBox(height: 16),
              CircularProgressIndicator(), // Show loading indicator
              SizedBox(height: 16),
              Text(_status), // Show status message
            ],
          ),
        ),
      ),
    );
  }
}