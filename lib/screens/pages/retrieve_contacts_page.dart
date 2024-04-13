import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RetrieveContactsPage extends StatefulWidget {
  @override
  _RetrieveContactsPageState createState() => _RetrieveContactsPageState();
}

class _RetrieveContactsPageState extends State<RetrieveContactsPage> {
  List<Map<String, dynamic>> emergencyContacts = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchEmergencyContacts();
  }

  Future<void> fetchEmergencyContacts() async {
    final accessToken = await storage.read(key: 'access_token');
    final url = 'https://supernova-fqn8.onrender.com/api/main/contact';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> contactsData = jsonDecode(response.body);
        setState(() {
          emergencyContacts = contactsData.cast<Map<String, dynamic>>();
        });
      } else {
        showSnackBar('Failed to fetch emergency contacts. Please try again.');
      }
    } catch (error) {
      showSnackBar('Error fetching emergency contacts. Please try again later.');
    }
  }

  void showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Close Contacts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Here are your close contacts',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,
                itemBuilder: (context, index) {
                  final contact = emergencyContacts[index];
                  return ListTile(
                    title: Text(contact['name']),
                    subtitle: Text(contact['mobile_no']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}