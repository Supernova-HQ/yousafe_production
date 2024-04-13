import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SOSRequestWidget extends StatefulWidget {
  @override
  _SOSRequestWidgetState createState() => _SOSRequestWidgetState();
}

class _SOSRequestWidgetState extends State<SOSRequestWidget> {
  String _status = 'Calling for Help...';
  bool _success = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  List<Map<String, dynamic>> emergencyContacts = [];

  @override
  void initState() {
    super.initState();
    _fetchEmergencyContacts();
    _startSOSProcess();
  }

  Future<void> _fetchEmergencyContacts() async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final url = Uri.parse('https://supernova-fqn8.onrender.com/api/main/contacts');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> contactsData = jsonDecode(response.body);
        setState(() {
          emergencyContacts = contactsData.cast<Map<String, dynamic>>();
        });
      } else {
        print('Failed to fetch emergency contacts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching emergency contacts: $error');
    }
  }

  Future<void> _sendEmergencySMS() async {
    final accessToken = await _secureStorage.read(key: 'access_token');
    final url = Uri.parse('https://supernova-fqn8.onrender.com/api/main/emergency/');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        print('Emergency SMS sent successfully');
      } else {
        print('Failed to send emergency SMS. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending emergency SMS: $error');
    }
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

    // Send emergency SMS to contacts
    await _sendEmergencySMS();

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