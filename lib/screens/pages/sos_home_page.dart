import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/sos_request.dart';

class SOSHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SOSRequestWidget()),
            );
            // Implement sending SOS logic here
            print('Sending SOS...');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red[600],
            shape: CircleBorder(),
            padding: EdgeInsets.all(80),
          ),
          child: Text(
            'TAP TO\nSEND SOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}